{-|
  Description : Validator main program.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Entry point for validator tool.
-}
module Main where
import Control.Monad
import Data.IORef

import System.Environment ( getArgs )
import System.IO
import System.Cmd

import MD.Syntax.LLVM (Decl(..), Block(..), blockTargets)
import MD.Syntax.GDSA
--import MD.Parser
import MD.Reshape
import MD.Driver
import MD.Sharing
import MD.Rules

import MD.DInterp (dinterp, Result(..))

main :: IO ()
main = do { ax <- liftM (filter (\s -> head s /= '-')) getArgs
          ; case ax of
              "ast":l            -> parse l >> return ()
              "pairs":f1:f2:[]   -> findPairs f1 f2 >>= \(ps,rs) ->
                                    forM_ ps (\(n,_,_) -> putStrLn n) >>
                                    putStrLn "REMOVED:" >>
                                    forM_ rs (\(n,_) -> putStrLn n)
              "dot":l            -> parse l >>= mapM_ dot
              "cfg":l            -> parse l >>= mapM_ cfg
              "dom":l            -> parse l >>= mapM_ domtree
              "vdot":l           -> parse l >>= showval
              "trace":l          -> parse l >>= tracer
              "blocks":l         -> parse l >>= display gf_blocks
              "rblocks":l        -> parse l >>= display (reshape . gf_blocks)
              "gblocks":l        -> parse l >>= display gf_gblocks
              "rules":l          -> parse l >>= display gf_rules
              "graph":l          -> parse l >>= display gf_graph
              "foo":[]           -> interp
              "smt":f1:f2:l      -> smt f1 f2 l
              "mgraph":f1:f2:n:l -> mgraph f1 f2 n l >>= maybe_dot
              f1:f2:l            -> validate f1 f2 l
              _ -> putStrLn "invalid args"
          }

interp :: IO ()
interp =
 do { gf <- parse ["foo.s"] >>= g
    ; let gr = gf_graph gf
    ; let args = [ (Ident "%n", C (Int 5)), (Ident "%m", C (Int 7)) ]
    ; dinterp gr args
    ; --print gr
    }
 where
   g [] = fail "foo not found"
   g (Function{ fName = "foo", fArgs = ax, fBlocks = bs }:_) = gFun "foo" ax bs
   g (_:l) = g l

-------------------------------------------------------------------------------
-- pretty printing phases

display :: Show a => (GFun -> a) -> [Decl] -> IO ()
display _ [] = return ()
display pj (Function { fName = n, fArgs = ax, fBlocks = bs }:l) =
    do { gf <- gFun n ax bs
       ; putStrLn (gf_name gf)
       ; print (pj gf)
       ; display pj l
       }
display pj (_:l) = display pj l

dot :: Decl -> IO ()
dot (Function { fName = n, fBlocks = bs }) = runDot n $ \h ->
    do { forM_ bs $ \b ->
         hPutStrLn h (show (blockName b) ++ "[label="++ show (blockIndex b) ++"]")
       ; forM_ bs $ \b ->
         hPutStrLn h (show (blockName b) ++ " -> { "++
                      unwords (map (show . show) $ blockTargets b) ++ "}")
       }
dot _ = return ()

runDot :: String -> (Handle -> IO ()) -> IO ()
runDot n io =
    do { let fn1 = n ++ ".dot"
       ; let fn2 = n ++ ".pdf"
       ; withFile fn1 WriteMode $ \h ->
         do { hPutStrLn h $ "digraph g {\nmargin=\"0\"\nsize =\"8.5,11.0\"\n"
            ; io h
            ; hPutStrLn h "}"
            }
       ; system $ "dot -Tpdf -o"++ fn2 ++" "++ fn1
       ; return ()
       }

cfg :: Decl -> IO ()
cfg (Function { fName = n, fArgs = ax, fBlocks = fbs }) = runDot (n++".cfg") $ \h ->
    do { gf <- gFun n ax fbs
       ; let bs = gf_gblocks gf
       ; forM_ bs $ \b ->
         hPutStrLn h (show (label b) ++ "[label="++ show (show(label b, idom b, pdom b)) ++"]")
       ; forM_ bs $ \b ->
         hPutStrLn h (show (label b) ++ " -> { "++
                      unwords (map show $ cfgsuc b) ++ "}")
       }
cfg _ = return ()

domtree :: Decl -> IO ()
domtree (Function { fName = n, fArgs = ax, fBlocks = fbs }) = runDot (n++".dom") $ \h ->
    do { gf <- gFun n ax fbs
       ; let bs = gf_gblocks gf
       ; forM_ bs $ \b ->
         hPutStrLn h (show (label b) ++ "[label="++ show (show(label b)++show(cfgsuc b)) ++"]")
       ; forM_ bs $ \b ->
         hPutStrLn h (show (label b) ++ " -> { "++
                      unwords (map show $ children b) ++ "}")
       }
domtree _ = return ()


-------------------------------------------------------------------------------
-- value graph tracing

showval :: [Decl] -> IO ()
showval [] = return ()
showval (Function { fName = name, fArgs = ax, fBlocks = bs }:l) =
    do { gf <- gFun name ax bs
       ; showGraph [] stdout (gf_graph gf)
       ; showval l
       }
showval (_:l) = showval l

tracer :: [Decl] -> IO ()
tracer [] = return ()
tracer (Function { fName = name, fArgs = ax, fBlocks = bs }:_) =
    do { g <- liftM gf_graph $ gFun name ax bs
       ; r <- newIORef 0
       ; wrdot r 0 (Memory[]) (Memory[]) g
       ; traceRules (wrdot r) g
       ; return ()
       }
 where
   wrdot :: IORef Int -> TraceCallback
   wrdot r u v v' vg =
       do { n <- readIORef r
          ; writeIORef r (n+1)
          ; let f = name ++ show n ++ ".dot"
          ; putStrLn f
          ; putStrLn (show u ++ ":\t"++ show v ++ "\n-->\t" ++ show v')
          ; withFile f WriteMode (\h -> showGraph [] h vg)
          }
tracer (_:l) = tracer l

maybe_dot :: (ValueGraph,[Int]) -> IO ()
maybe_dot (_,[]) = return ()
maybe_dot (g,ns) = showGraph ns stdout g

showGraph :: [Int] -> Handle -> ValueGraph -> IO ()
showGraph ns h vg =
    do { hPutStrLn h $ "digraph name {\nmargin=\"0\"\nsize =\"8.5,11.0\"\n"
       ; forM_ ps $ \(n,v) ->
         hPutStrLn h (show n ++ "[label=\""++valn v ++"\"]") -- ++ unwords (names n) ++":"
       ; forM_ ps $ \(n,v) ->
         hPutStrLn h (show n ++ " -> { "++
                   unwords (map (show . show) $ refs v) ++ "}")
       ; hPutStrLn h "}"
       }
 where
   ps | null ns   = alist vg
      | otherwise = filter (\(a,_) -> a `elem` ns) (alist vg)

valn :: Value -> String
valn (Param i)    = show i
valn (Memory _)   = "Memory"
valn (CV term)    = case term of
  Const c            -> show c
  Proj p _           -> show p
  GetElemPtr _ _ _   -> "&"
  BinOp o _ _ _ _    -> plop o
  Conv op _ _ _      -> show op
  Select _ _ _       -> "select"
  Extract _ _ _      -> "extract"
  Alloc _ _ _        -> "Alloc"
  Load _ _ _         -> "load"
  Store _ _ _ _      -> "store"
  Call _ _ _         -> "call"
  Phi _ _            -> "phi"
  Mu _ _ _           -> "mu"
  Eta _ _            -> "eta"
  Returns _          -> "ret"

plop :: Opr -> String
plop (Bop Add) = "+"
plop (Bop Shl) = "<<"
plop (Cmp MD.Syntax.GDSA.EQ) = "=="
plop (Cmp NE) = "!="
plop (Cmp SLT) = "<"
plop (Bop SRem) = "%"
plop o = show o
