{-# LANGUAGE PatternGuards #-}
{-|
  Description : Validator main program.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Driver functions for the validator.
-}
module MD.Driver where
import Control.Monad
import Control.Exception
import Data.List
import Data.Maybe
import Data.IORef
import Data.Binary
import GHC.IO
import System.Directory
import System.FilePath

import MD.Syntax.LLVM (Module(..), Decl(..), Argument(..), Block(..))
import MD.Syntax.GDSA
import MD.Parser
import MD.Reshape
import MD.Binary
import MD.Convert
--import MD.Gating
import MD.LoopDetection
import MD.Phi
import MD.Mu
--import MD.Rewrite
import MD.Sharing
--import MD.Partitioning
import MD.Rules
import MD.GenerateSmt

import MD.Inliner

import System.IO
import System.Timeout
import System.CPUTime

-------------------------------------------------------------------------------
-- | Entry point for validator. The first two arguments are the names of the
-- two files that should be compared. The third argument is a list of
-- functions to compare; this list can be empty, in which case all functions
-- found in the first file will be used.

validate :: FilePath -> FilePath -> [String] -> IO ()
validate f1 f2 l =
    do { pairs <- loadCandidates f1 f2
       ; let ps = case l of
                    [] -> pairs
                    _  -> filter (\p -> gf_name (fst p) `elem` l) pairs
       ; forM_ ps comp
       ; putStrLn "COMPLETE"
       }
 where
   alarm g t1 t2 | null l    = return ()
                 | otherwise = diff g t1 t2 >> partIO g
   comp (a,b) = catchAny
                (do x <- timeout 999999 (comp' a b)
                    case x of
                      Just y  -> return y
                      Nothing -> putStrLn ("FAIL TIMEOUT "++gf_name a)
                )
                (\e -> putStrLn ("FAIL "++gf_name a ++":"++ show e))
   comp' (GFun { gf_name    = n
               , gf_rules   = rr1})
         (GFun { gf_rules   = rr2}) =
         do { --print n
            ; hFlush stdout
            ; time1 <- getCPUTime
            ; let g' = graphize (graphize emptyGraph rr1) rr2
            ; g <- if (null l)
                   then return $ applyRules g'
                   else do { putStrLn "INITIAL DUAL-GRAPH"
                           ; print g'
                           ; putStrLn "APPLYING RULES"
                           ; g'' <- traceRules tcb g'
                           --; g'' <- return (applyRules g')
                           ; putStrLn "\nFINAL DUAL-GRAPH"
                           ; print g''
                           ; return g''
                           }
            ; let rs = if countReturns g == 1 then [0,0] else findReturns g
            ; let (t1,t2) = case rs of
                              []    -> error (n++":no returns found")
                              [a]   -> (a,a)
                              [a,b] -> (a,b)
                              xs    -> error (show (length xs)++ " returns found")
            ; if t1 == t2
              then do time2 <- getCPUTime
                      putStrLn ("OK "++
                                show (gSize g') ++ " "++
                                timediff time1 time2 ++ " "++
                                n)
              else do time2 <- getCPUTime
                      putStrLn ("ALARM "++
                                show (gSize g') ++ " "++
                                timediff time1 time2 ++ " "++
                                n)
                      alarm g t1 t2
                      --putStrLn (show g) >>
                      --partIO g >>
                      return ()
            }
   tcb u v v' _ = putStrLn (show u ++ ":\t"++ show v ++ "\n-->\t" ++ show v')
   timediff t1 t2 =  show (fromIntegral (t2 - t1) / 1000000000.0 :: Double) ++ "ms"


mgraph :: FilePath -> FilePath -> String -> [String] -> IO (ValueGraph,[Int])
mgraph f1 f2 n l =
    do { pairs <- loadCandidates f1 f2
       ; let ~[(a,b)] = filter (\p -> gf_name (fst p) == n) pairs
       ; let rr1 = gf_rules a
       ; let rr2 = gf_rules b
       ; let g' = graphize (graphize emptyGraph rr1) rr2
       ; g <- traceRules tcb g'
       ; ls <- case filter (\s -> '-' /= head s) l of
                 [] -> do print g
                          return []
                 ns -> do lls <- mapM (fragment g . read) ns
                          return (nub $ concat lls)
       ; return (g, ls)
       }
 where
   tcb u v v' _ = putStrLn (show u ++ ":\t"++ show v ++ "\n-->\t" ++ show v')
   fragment :: ValueGraph -> Int -> IO [Int]
   fragment g nd =
       do lr <- newIORef []
          outp lr 0 nd
          readIORef lr
     where
       outp lr t n =
           do l <- readIORef lr
              if n `elem` l then return ()
               else do let x = fetchVal g n
                       putStrLn (take t (repeat ' ') ++ show n ++" --> "++ show x)
                       writeIORef lr (n:l)
                       mapM_ (outp lr (t+1)) (refs x)

-------------------------------------------------------------------------------
-- entry point for SMT generation.

smt :: FilePath -> FilePath -> [String] -> IO ()
smt f1 f2 l =
    do { pairs <- loadCandidates f1 f2
       ; let ps = case l of
                    [] -> pairs
                    _  -> filter (\p -> gf_name (fst p) `elem` l) pairs
       ; forM_ ps smt'
       }
 where
   smt' (gf1,gf2) =
       do { let g' = graphize (graphize emptyGraph (gf_rules gf1)) (gf_rules gf2)
          ; g <- evaluate {-$ applyRules-} g'
          ; case findReturns g of
              []    -> fail ("no returns found")
              [_]   -> putStrLn ("Ok "++ gf_name gf1)
              [a,b] -> do { putStrLn ("Generating SMT for "++ gf_name gf1)
                          ; let fn = gf_name gf1 ++ ".smt"
                          ; catchAny
                            (withFile (gf_name gf1 ++ ".smt") WriteMode $ \h -> hPutStrLn h (script g a b))
                            (\e -> do print e; removeFile fn)
                          }
              xs    -> fail (show (length xs)++ " returns found")
          }

   -- DELETE THIS AND USE GenerateSmt
   -- script takes combined value graph and the two return nodes
   -- it returns a string which is printed out.
   {-
   script :: ValueGraph -> Int -> Int -> String
   script = undefined
   -}

-------------------------------------------------------------------------------
-- reading input

parse :: [String] -> IO [Decl]
parse []    = fail "no filename"
parse (f:l) =
    do { Module m <-
             if takeExtension f == "ast" then decodeAST f
             else do { let f' = dropExtension f <.> "ast"
                     ; ex <- doesFileExist f'
                     ; if ex then
                           do { st <- getModificationTime f
                              ; bt <- getModificationTime f'
                              ; if st >= bt then parse' f f'
                                else decodeAST f'
                              }
                       else parse' f f'
                     }
       ; case l of
           []    -> return m
           (n:_) -> return [findFn n m]
       }
 where
   parse' s b = parseFile True s >>= encodeAST b

findFn :: String -> [Decl] -> Decl
findFn _ [] = error "no fn"
findFn s (d@(Function { fName = n }):_) | n == s = d
findFn s (_:l) = findFn s l

-------------------------------------------------------------------------------
-- Building ruleset pairs

loadCandidates :: FilePath -> FilePath -> IO [(GFun, GFun)]
loadCandidates f1 f2 =
    do { (ps,rm) <- findPairs f1 f2
       ; ins <- foldM t2 [] rm
       ; fns <- foldM (tr ins) [] ps
       ; return fns
       }
 where
   tr ins l (n,bs1,bs2) = do { g1 <- trans n bs1
                             ; g2 <- trans n bs2
                             ; case (g1,g2) of
                                 (Just a, Just b) -> return ((inl ins a, b):l)
                                 _                -> return l
                             }
   inl ins x = x { gf_graph = inline ins (gf_graph x) }
   t2 l (n,bs) = do { g <- trans n bs
                    ; case g of
                        Just x  -> return ((gf_name x, gf_graph x):l)
                        Nothing -> return l
                    }

type AstPairs = [(String, [Block], [Block])]
type Removed  = [(String, [Block])]

findPairs :: FilePath -> FilePath -> IO (AstPairs,Removed)
findPairs f1 f2 =
    do { ex <- doesFileExist fname
       ; if ex then
             do { t1 <- getModificationTime f1
                ; t2 <- getModificationTime f2
                ; tp <- getModificationTime fname
                ; if tp >= t1 && tp >= t2
                  then decodeFile fname
                  else load
                }
         else load
       }
  where
    fname = dropExtension f1 <.> takeFileName (dropExtension f2) <.> "astpairs"
    load  = do ps <- parse2 f1 f2
               encodeFile fname ps
               return ps

parse2 :: FilePath -> FilePath -> IO (AstPairs,Removed)
parse2 f1 f2 =
    do { ds1 <- parse [f1]
       ; ds2 <- parse [f2]
       ; save [] [] ds2 ds1
       }
 where
   save res rms _  []     = return (res,rms)
   save res rms l2 (d:ds) =
       case d of
         Function { fName = n, fBlocks = bs1} ->
             case find (isfn n) l2 of
               Nothing -> putStrLn ("REMOVED "++n) >>
                          save res ((n,bs1):rms) l2 ds
               Just g | fBlocks g == bs1 -> putStrLn ("BORING "++n) >>
                                            save res rms l2 ds
                      | otherwise ->
                          do { let bs2 = fBlocks g
                             ; save ((n,bs1,bs2):res) rms l2 ds
                             }
         _ -> save res rms l2 ds

   isfn n (Function { fName = n' }) = n == n'
   isfn _ _ = False

-------------------------------------------------------------------------------
-- translating to rules and graphs

trans :: String -> [Block] -> IO (Maybe GFun)
trans name bs = catchAny (liftM Just $ rFun name bs) h
 where
   h e = putStrLn ("FAIL "++name ++":"++ show e) >> return Nothing

data GFun = GFun
   { gf_name :: String
   , gf_args :: [Ident]
   , gf_blocks :: [Block]
   , gf_gblocks :: [GBlock]
   , gf_rules :: [RR]
   , gf_graph :: ValueGraph
   }

instance Eq GFun where
    f == g = gf_name f == gf_name g

rFun :: String -> [Block] -> IO GFun
rFun n bs =
    do { let bs'  = reshape bs
       ; let gbs' = convertToGDSA bs'  -- convert basic blocks to term language
       ; --foo <- tarjan gbs'
       ; --fail "STOP"
       ; x <- ld gbs'                 -- loop detection phase
       ; let y = mkMU x               -- compute mu nodes and produce rewrite rules;
       ; let gbs = computePhi y       -- translate non-loop phi nodes
       ; --fail "done"
       ; --let gbs = {-computeGates-} gbs'
       ; let rr = concatMap rules gbs
       ; return $ GFun n [] [] gbs rr emptyGraph
       }

gFun :: String -> [Argument] -> [Block] -> IO GFun
gFun n ax bs =
    do { gfn <- rFun n bs
       ; return $ gfn { gf_args    = map proj ax
                      , gf_blocks  = reshape bs
                      , gf_gblocks = sortBy bnum (gf_gblocks gfn)
                      , gf_graph   = gMin $ graphize (gf_graph gfn) (gf_rules gfn)
                      }
       }
 where
   bnum b1 b2 = compare (label b1) (label b2)
   proj (Arg _ _ x) = x
   proj Dots = error "var args"

-------------------------------------------------------------------------------
-- Ouput difference between two graphs.

diff :: ValueGraph -> Int -> Int -> IO ()
diff vg x y =
    do { r <- newIORef []
       ; diff' r (alist vg) (x,y)
       }

diff' :: IORef [Int] -> [(Int,Value)] -> (Int,Int) -> IO ()
diff' seen ns (a,b) =
    do { l <- readIORef seen
       ; writeIORef seen (a:b:l)
       ; if a `notElem` l && b `notElem` l
         then do { putStrLn (show a ++" /= "++ show b)
                 ; let av = fetch a
                 ; let bv = fetch b
                 ; mapM_ (diff' seen ns) =<< df av bv
                 }
         else return ()
       }
 where
   fetch x = fromJust $ lookup x ns

df :: Value -> Value -> IO [(Int,Int)]
df v1 v2 =
    if v1 == v2 then return []
    else if valname v1 == valname v2
         then pr (refs v1) (refs v2)
         else out >> return []
 where
   out      = putStrLn ("  "++show v1 ++"\n  "++ show v2)
   pr l1 l2 = out >>
              let xs  = intersect l1 l2 in
              let l1' = l1 \\ xs in
              let l2' = l2 \\ xs in
              return (zip l1' l2')
