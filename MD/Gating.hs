{-# LANGUAGE TupleSections, PatternGuards #-}
{-|
  Description : Generate guarded phi-, mu-, and eta-nodes.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module computes the gating functions for our Gated SSA form.
-}
module MD.Gating
  ( tarjan )
where
import Prelude hiding (sequence)
import Control.Monad hiding (sequence)
import Control.Monad.ST
import Data.STRef
import qualified Data.IntMap as M
import qualified Data.Map as Map
import Data.List
import Data.Maybe
import MD.Syntax.GDSA
import MD.Graph hiding (Forest)
import Data.Array.IArray as A
import Debug.Trace


-------------------------------------------------------------------------------

type Blocks = A.Array Label GBlock
type Forest = M.IntMap (Label,Gate)

emptyForest :: Forest
emptyForest = M.empty

fetchNode :: Label -> Forest -> (Label,Gate)
fetchNode l f = case M.lookup l f of
                  Nothing -> error "fetch"
                  Just x  -> x

setParent :: Label -> Label -> Forest -> Forest
setParent p l = M.adjust (\(_,g) -> (p,g)) l

setGate :: Gate -> Label -> Forest -> Forest
setGate g l = M.adjust (\(p,_) -> (p,g)) l


data M a = M { runM :: Blocks -> PathMap -> Forest -> (PathMap,Forest,a) }

instance Monad M where
    return x = M $ \e s f -> (s,f,x)
    m >>= k  = M $ \e s f -> let (s',f',x) = runM m e s f in
                             runM (k x) e s' f'

blocks :: M Blocks
blocks = M $ \e s f -> (s,f,e)

blockOf :: Label -> M GBlock
blockOf l = do bs <- blocks; return (bs ! l)

forest :: M Forest
forest = M (\e s f -> (s,f,f))

setForest :: Forest -> M ()
setForest f = M (\e s _ -> (s,f,()))

solveState :: M PathMap
solveState = M $ \e s f -> (s,f,s)

setSolveState :: PathMap -> M ()
setSolveState s = M $ \e _ f -> (s,f,())

reset :: M ()
reset = setSolveState emptyPathMap

get :: PathName -> M Gate
get n = solveState >>= \m -> return (fetch m n)

set :: PathName -> Gate -> M ()
set n g = solveState >>= \m -> setSolveState (store m n g)

evalM :: [GBlock] -> M a -> a
evalM cfg m =
    let (_,_,x) = runM m env emptyPathMap emptyForest
    in x
 where
   bounds = (0, length cfg + 1)
   blks   = sortBy (\b1 b2 -> compare (label b1) (label b2)) cfg
   env    = A.array bounds [(label b, b) | b <- blks]


parent :: Label -> M Label
gate   :: Label -> M Gate
parent l = liftM (fst . fetchNode l) forest
gate   l = liftM (snd . fetchNode l) forest

update :: Label -> Gate -> M ()
link   :: Label -> Label -> M ()
update l g = do f <- forest; setForest (setGate g l f)
link   p l = do f <- forest; setForest (setParent p l f)

initialize :: Label -> M ()
initialize v = do link 0 v; update v Lambda

eval :: Label -> M Gate
eval 0 = return Lambda
eval v = do compress v; gate v

compress :: Label -> M ()
compress v = do p  <- parent v
                pp <- parent p
                when (pp /= 0) $
                 do compress p
                    gv <- gate v
                    gp <- gate p
                    update v (simplify (gp :. gv))
                    link v pp

-------------------------------------------------------------------------------

idomOrdering :: M [Label]
idomOrdering = liftM reverse (next [] 0)
 where
   next ls l = childrenOf l >>= foldM next (l:ls)

childrenOf :: Label -> M [Label]
childrenOf l = liftM children (blockOf l)

tree     :: Label -> M [(Label,Label)]
non_tree :: Label -> M [(Label,Label)]

tree     l = do b <- blockOf l; return [ (x,l) | x <- cfgpre b, x == idom b ]
non_tree l = do b <- blockOf l; return [ (x,l) | x <- cfgpre b, x /= idom b ]

subsequence :: Label -> M PathSequence
subsequence l =
    do cs <- childrenOf l
       bs <- liftM (filter (\b -> label b `elem` l:cs) . A.elems) blocks
       let es = [ (l,x) | x <- topOrder bs ]
       pm <- foldM f emptyPathMap bs
       return $ (es, pm)
 where
   f m b = liftM (store m (l,label b))
                 (pathExprOf l (label b))

pathExprOf :: Label -> Label -> M Gate
pathExprOf h t = liftM2 pathExpr (blockOf h) (blockOf t)

tarjan_fast :: [GBlock] -> IO [GBlock]
tarjan_fast bs =
    do { putStrLn "Tarjan Fast!"
       ; let upperBound = maximum (map label bs)
       ; let bs' = sortBy (\b1 b2 -> compare b1 b2) bs
       ; return $ evalM bs decompose_and_sequence
       ; return bs
       }


decompose_and_sequence :: M ()
decompose_and_sequence =
    do { labels <- idomOrdering
       ; forM_ labels initialize
       ; forM_ labels $ \u ->
         do { blk <- blockOf u
            ; let cs_u   = children blk
            ; let idom_u = idom blk
            ; forM_ cs_u $ \v ->
                do nt <- non_tree v
                   forM_ nt evalEdge
            ; subseq <- subsequence u
            ; pathMap <- solveChildren subseq idom_u u
            ; forM_ cs_u $ \v ->
                do update v (fetch pathMap (idom_u, u))
                   link u v
            ; return ()
            }
       ; return ()
       }

derived_simple :: M.IntMap GBlock -> Label -> Label -> Maybe (Label,Label)
derived_simple _ a b = Just (a,b)

derived' :: M.IntMap GBlock -> Label -> Label -> Maybe (Label,Label)
derived' blks h t = h' >>= \x -> return (x,t)
 where
   h' | h == iDom t = Just h
      | ss == []    = Nothing
      | otherwise   = pathTo (cfgPre t)

   ss = siblings t

   pathTo [] = Nothing
   pathTo ls = case find (`elem` ss) ls of
                 Nothing -> pathTo (concatMap cfgPre ls)
                 Just l  -> Just l

   iDom     :: Label -> Label
   siblings :: Label -> [Label]
   cfgPre   :: Label -> [Label]

   hb = blockOf h
   tb = blockOf t

   iDom l = idom (blockOf l)
   cfgPre l = cfgpre (blockOf l)
   blockOf = getb blks

   bs = map snd $ M.toList blks
   siblings l = siblings' (blockOf l)
   siblings' b = [ label x | x <- bs, x /= b, idom x == idom b ]


subsequence' :: Label -> M PathSequence
subsequence' l =
    do cs <- childrenOf l
       bs <- liftM (filter (\b -> label b `elem` l:cs) . A.elems) blocks
       dg <- derivedGraph bs
       substDerived (generateSequence dg)

derivedGraph :: [GBlock] -> M [GBlock]
derivedGraph bs = mapM replaceEdges bs
 where
   replaceEdges b =
       do pre' <- mapM (replaceEdge $ label b) (cfgpre b)
          return b { cfgpre = pre' }

   replaceEdge h t = liftM fst (derivedEdge h t)

substDerived :: PathSequence -> M PathSequence
substDerived (es,pm) =
    do dm <- getDerived
       let pm' = mapGates pm (lookupGate dm)
       return (es,pm')
 where
   getDerived :: M PathMap
   mapGates   :: PathMap -> (PathName -> Gate -> Gate) -> PathMap
   lookupGate :: PathMap -> PathName -> Gate -> Gate

   getDerived = undefined
   mapGates m f = Map.mapWithKey f m
   lookupGate m n g = Map.findWithDefault g n m

--evalEdge (h,t) = eval t
evalEdge :: (Label,Label) -> M Gate
evalEdge (h,t) =
    do p <- eval t
       de <- derivedEdge h t
       storeDerived de p
       return p
 where
   storeDerived :: PathName -> Gate -> M ()
   storeDerived = undefined

derivedEdge :: Label -> Label -> M (Label,Label)
derivedEdge h t = undefined

derived :: Label -> Label -> M (Label,Label)
derived h t =
    do tBlock <- blockOf t
       if h == idom tBlock
        then return (h,t)
        else do ss <- siblings t
                h' <- pathTo ss [t]
                return (h',t)
 where
   siblings :: Label -> M [Label]
   siblings l = do cs <- blockOf l >>=
                         childrenOf . idom
                   return [ b | b <- cs, b /= l ]

   pathTo [] _  = fail "no siblings"
   pathTo ss [] = fail "no sibling found"
   pathTo ss ls =
       case find (`elem` ss) ls of
         Nothing -> do lls' <- mapM cfgpreOf ls
                       pathTo ss (concat lls')
         Just l  -> return l

   cfgpreOf :: Label -> M [Label]
   cfgpreOf l = liftM cfgpre (blockOf l)

{-

   h' | h == iDom t = Just h
      | ss == []    = Nothing
      | otherwise   = pathTo (cfgPre t)

   ss = siblings t


   iDom     :: Label -> Label
   siblings :: Label -> [Label]
   cfgPre   :: Label -> [Label]

   hb = blockOf h
   tb = blockOf t

   iDom l = idom (blockOf l)
   cfgPre l = cfgpre (blockOf l)
   blockOf = getb blks

   bs = map snd $ M.toList blks
   siblings l = siblings' (blockOf l)
   siblings' b = [ label x | x <- bs, x /= b, idom x == idom b ]
-}


solveChildren :: PathSequence -> Label -> Label -> M PathMap
solveChildren pathSeq root lbl =
    do reset
       cs <- childrenOf lbl
       solveChildrenInit root cs
       solveChildrenLoop pathSeq root lbl
       solveState

solveChildrenInit :: Label -> [Label] -> M ()
solveChildrenInit s csu =
    forM_ csu $ \v ->
      do set (s,v) Empty
         tr <- tree v
         forM_ tr $ \(h,t) ->
           do sv <- get (s,v)
              ht <- pathExprOf h t
              set (s,v) (sv :+ ht)

solveChildrenLoop :: PathSequence -> Label -> Label -> M ()
solveChildrenLoop (labels,pm) s u =
    forM_ labels $ \(w,x) ->
      do p <- get (w,x)
         sw <- get (s,w)
         sx <- get (s,x)
         if x == w
           then set (s,w) (sw :. p)
           else set (s,x) (sx :+ (sw :. p))

-------------------------------------------------------------------------------


tarjan :: [GBlock] -> IO [GBlock]
tarjan bs =
    do { putStrLn "Running tarjan"
       ; print (dfOrder bs)
       ; let blocks = M.fromList [ (label b, b) | b <- bs ]
       ; let ps@(_,pm) = generateSequence bs
       ; putStrLn (Map.showTree pm)
       ; mapM_ pr  (Map.toList pm)
       ; mapM_ prs (Map.toList pm)
       ; let pm2 = solve ps 1
       ; putStrLn (Map.showTree pm2)
       ; mapM_ pr  (Map.toList pm2)
       ; mapM_ prs (Map.toList pm2)
       ; mapM_ pp  (Map.toList pm2)
       ; fail "TARJAN DONE"
       ; return bs
       }
 where
   prs  (p,x) = pr (p,simplify x)
   pr   (p,x) = putStrLn (show p ++ "&\\mapsto "++ tex x ++ " \\\\")
   pp   (p,x) = putStrLn (show p ++ " = "++ show (simplify x))

-- Simple Cubic Algorithm

type PathSequence = ([PathName], PathMap)
type PathName     = (Label,Label)
type PathMap      = Map.Map PathName Gate

emptyPathMap :: PathMap
emptyPathMap = Map.empty

adjust :: (PathName -> Gate -> Gate) -> PathMap -> PathName -> PathMap
adjust f m e@(x,y)  = Map.alter adj e m
 where adj Nothing  = Just $ f e Empty
       adj (Just g) = Just $ f e g

fetch :: PathMap -> PathName -> Gate
fetch m e = Map.findWithDefault Empty e m

store :: PathMap -> PathName -> Gate -> PathMap
store m e g = Map.insert e g m


-- sections

type Section = [Int]

dfOrder  :: [GBlock] -> Section
topOrder :: [GBlock] -> Section

dfOrder    = reverse . topOrder
topOrder   = map label . topsortBlocks


--section :: [GBlock] -> Section
--section bs = reverse $ map label $ topsortBlocks bs
--dfOrder    = section
--topOrder   = reverse . section

sectionAfter :: Label -> Section -> Section
sectionAfter _ [] = []
sectionAfter n (m:l) | n == m    = l
                     | otherwise = sectionAfter n l

sectionFrom :: Label -> Section -> Section
sectionFrom _ [] = []
sectionFrom n (m:l) | n == m    = n:l
                    | otherwise = sectionFrom n l

sectionTo :: Label -> Section -> Section
sectionTo _ [] = []
sectionTo n (m:l) | n == m    = []
                  | otherwise = m : sectionTo n l

--

elimInit :: [GBlock] -> PathMap
elimInit blocks =
    foldl (adjust initEdge) emptyPathMap (edges blocks)
 where
   initEdge (x,y) exp = exp :+ evalEdge x y

   edges :: [GBlock] -> [(Label,Label)]
   edges blocks = nub $ concatMap outEdges blocks
   outEdges b   = [ (label b, x) | x <- cfgsuc b]

   evalEdge :: Label -> Label -> Gate
   evalEdge m n = pathExpr (blockOf m) (blockOf n)

   blks = M.fromList [ (label b, b) | b <- blocks ]
   blockOf = getb blks

eliminate :: [GBlock] -> PathMap
eliminate blocks =
    runST $ do let xx = elimInit blocks
               psr <- trace (tr xx) $ newSTRef xx
               elimLoop (topOrder blocks) psr
               readSTRef psr
 where
   tr pm = unlines $ map sh $ Map.toList pm
   sh (p,x) = show p ++ "&\\mapsto "++ tex x ++ " \\\\"

elimLoop :: Section -> STRef a PathMap -> ST a ()
elimLoop ns psr =
    forM_ ns $ \v ->
    do vv <- get (v,v)
       trace ("SET "++show (v,v)++" "++ show vv ++ " -> "++show (Star vv))$
        set (v,v) (Star vv)
       forM_ (sectionAfter v ns) $ \u ->
         do uv <- get (u,v)
            vv <- get (v,v)
            when (notEmpty uv) $
             do trace (" SET "++ show (u,v) ++" "++ show (uv,vv)++" -> "++ show (uv :. vv))$
                 set (u,v) (uv :. vv)
                forM_ (sectionAfter v ns) $ \w ->
                  do uw <- get (u,w)
                     uv <- get (u,v)
                     vw <- get (v,w)
                     when (notEmpty vw) $
                      trace ("  SET "++ show (u,v,w) ++" "++ show (uw,vw)++" -> "++ show (uw :+ (uv :. vw)))$
                       set (u,w) (uw :+ (uv :. vw))
 where
   --get :: PathName -> ST a Gate
   --set :: PathName -> Gate -> ST a ()
   get e = readSTRef psr >>= \m -> return (fetch m e)
   set e g = readSTRef psr >>= \m -> writeSTRef psr (store m e g)

generateSequence :: [GBlock] -> PathSequence
generateSequence blocks =
    let pm  = eliminate blocks in
    let lowerLeft  = trace ("LL" ++ show [ (u,w) | u <- labels, w <- sectionFrom u labels])
                     [ (u,w) | u <- labels, w <- sectionFrom u labels
                             , let uw =fetch pm (u,w), notEmpty uw, notLambda uw ] in
    let upperRight = trace ("UR" ++ show [ (u,w) | u <- labels, w <- sectionTo u labels])
                     [ (u,w) | u <- labels, w <- sectionTo u labels
                             , notEmpty (fetch pm (u,w)) ] in
    trace (show lowerLeft ++ show upperRight) $
     (lowerLeft ++ reverse upperRight, pm)
 where
   labels = topOrder blocks

solve :: PathSequence -> Label -> PathMap
solve pathSeq source = runST $
    do ref <- newSTRef initialize
       solveLoop pathSeq source ref
       readSTRef ref
 where
   initialize = store emptyPathMap (source,source) Lambda
   --initialize = foldl initV emptyPathMap labels
   --initV pm v | v == s    = store pm (s,v) Lambda
   --           | otherwise = store pm (s,v) Empty

solveLoop :: PathSequence -> Label -> STRef a PathMap -> ST a ()
solveLoop (labels,pm) s spm =
    forM_ labels $ \(v,w) ->
      let vw = fetch pm (v,w) in
      if v == w
      then do sv <- get (s,v)
              trace (show (s,v,w) ++ "dot"++
                     "\n  sv1:"++ show sv++
                     "\n  sv2:"++ show (fetch pm (s,v))++
                     "\n  vw:"++ show vw++
                     "\n  dot1:" ++ show (sv :. vw)++
                     "\n  dot2:" ++ show (fetch pm (s,v) :. vw)++
                     "\n") $
               set (s,v) (sv :. vw)
      else do sv <- get (s,v)
              sw <- get (s,w)
              trace (show ((s,v,w),"cupdot") ++
                     "\n  "++show sw++ " -> " ++ show (simplify sw) ++
                     "\n  "++show sv++ " -> " ++ show (simplify sv) ++
                     "\n  "++show vw++ " -> " ++ show (simplify vw) ++
                     "\n  "++ show (sw :+ (sv :. vw))++
                     "\n") $
               set (s,w) (sw :+ (sv :. vw))
 where
   --get :: PathName -> ST a Gate
   --set :: PathName -> Gate -> ST a ()
   get e = readSTRef spm >>= \m -> return (fetch m e)
   set e g = readSTRef spm >>= \m -> writeSTRef spm (store m e g)

solveLoop' :: PathSequence -> Label -> STRef a PathMap -> ST a ()
solveLoop' (labels,pm) s spm =
    forM_ labels $ \(v,w) ->
      do sv <- get (s,v)
         sw <- get (s,w)
         let vw = fetch pm (v,w)
         if v == w
          then set (s,v) (sv :. vw)
          else set (s,w) (sw :+ (sv :. vw))
 where
   --get :: PathName -> ST a Gate
   --set :: PathName -> Gate -> ST a ()
   get e = readSTRef spm >>= \m -> return (fetch m e)
   set e g = readSTRef spm >>= \m -> writeSTRef spm (store m e g)



-- End Simple Cubic Algorithm


-------------------------------------------------------------------------------
-- Gating functions

----- CHANGE GAMMA TO BE:
-- Gamma from to cond (no exprs)
-- Gamma is our RE atom which carries a value

data PathExpr a
   = Lambda
   | Empty
   | Gamma { from :: Int, to :: Int, value :: a }
   | PathExpr a :+ PathExpr a
   | PathExpr a :. PathExpr a
   | Star (PathExpr a)
     deriving Eq

gateToCondition :: Gate -> Term
gateToCondition g =
  case simplify g of
    Lambda       -> true
    Empty        -> false
    Gamma _ _ c  -> conj c
    p :+ q       -> disj [gateToCondition p, gateToCondition q]
    p :. q       -> conj [gateToCondition p, gateToCondition q]
    Star p       -> gateToCondition g
 where
   true, false :: Term
   conj :: [Term] -> Term
   disj :: [Term] -> Term
   true = undefined
   false = undefined
   conj = undefined
   disj = undefined

notEmpty,notLambda :: Gate -> Bool
notEmpty (Empty{}) = False
notEmpty _ = True
notLambda (Lambda{}) = False
notLambda _ = True


simplify :: PathExpr a -> PathExpr a
simplify (Star x) = gstar (simplify x)
simplify (x :+ y) = gcup (simplify x) (simplify y)
simplify (x :. y) = gdot (simplify x) (simplify y)
simplify g        = g

gcup :: PathExpr a -> PathExpr a -> PathExpr a
gcup Empty g = g
gcup g Empty = g
gcup x y     = x :+ y

gdot :: PathExpr a -> PathExpr a -> PathExpr a
gdot Empty _   = Empty
gdot _ Empty   = Empty
gdot Lambda g  = g
gdot g Lambda  = g
gdot x y       = x :. y

gstar :: PathExpr a -> PathExpr a
gstar Empty  = Lambda
gstar Lambda = Lambda
gstar g      = Star g


type Gate = PathExpr [Term]

pathExpr :: GBlock -> GBlock -> Gate
pathExpr bx by =
    case control bx of
      Seq z | y == z   -> Gamma x y []
      MBr c ty dl arms
          | dl == y    -> Gamma x y $ map (ne c . fst) arms
          | otherwise  -> Gamma x y [ eq c (yval arms) ]
      _ -> error "CFG error"
 where
   x = label bx
   y = label by

   yval :: [(Term,Label)] -> Term
   yval ax = case find (\(_,l) -> l == y) ax of
               Just (v,_) -> v
               Nothing    -> error "no arm for pe"

   eq,ne :: Term -> Term -> Term
   eq x y = CT (BinOp (Cmp MD.Syntax.GDSA.EQ)  "" (I 1) x y)
   ne x y = CT (BinOp (Cmp NE)  "" (I 1) x y)

instance Show a => Show (PathExpr a) where
    show Lambda        = "L"
    show Empty         = "E"
    show (Gamma f t _) = "G"++ show (f,t)
    show (Star e)      = "("++ show e ++")*"
    show (x :+ y)      = "("++ show x ++ " U " ++ show y ++")"
    show (x :. y)      = "("++ show x ++ " . " ++ show y ++")"

tex Lambda        = "\\Lambda"
tex Empty         = "\\emptyset"
tex (Gamma f t _) = "\\gamma_{"++ show (f,t) ++"}"
tex (Star e)      = p tex e ++ "^*"
tex (x :+ y)      = p tex x ++ " \\cup " ++ p tex y
tex (x :. y)      = p tex x ++ " \\cdot " ++ p tex y

p f e = case e of
  Lambda{} -> f e
  Empty {} -> f e
  Gamma {} -> f e
  Star  {} -> f e
  _        -> "\\left("++ f e ++ "\\right)"

-------------------------------------------------------------------------------
-- State


getb :: M.IntMap GBlock -> Label -> GBlock
getb bs n = case M.lookup n bs of
              Nothing -> error "cg:getb"
              Just b  -> b

{-
data St = St
   { uPhi   :: M.IntMap Bool
   , lPhi   :: M.IntMap Bool
   , gp     :: M.IntMap Gate
   , gstar' :: M.IntMap Gate
   , listP  :: M.IntMap [Gate]
--   , r      :: M.IntMap Gate
   , blocks :: M.IntMap GBlock
   }

initial :: [GBlock] -> St
initial bs = St { uPhi   = M.fromList [ (label b, False)     | b <- bs ]
                , lPhi   = M.fromList [ (label b, assigns b) | b <- bs ]
                , gp     = M.fromList [ (label b, Empty 0 0) | b <- bs ]
                , gstar' = M.fromList [ (label b, Empty 0 0) | b <- bs ]
                , listP  = M.fromList [ (label b, [])        | b <- bs ]
--                , r      = M.fromList [ (label b, Empty 0 0) | b <- bs ]
                , blocks = M.fromList [ (label b, b)         | b <- bs ]
                }
 where
   assigns b = not $ null $ rules b

getSt :: Show b => String -> STRef a St -> (St -> M.IntMap b) -> Label -> ST a b
getSt ss ref proj x =
    do { st <- readSTRef ref
       ; case M.lookup x (proj st) of
           Nothing -> fail ("getSt "++ ss ++ " "++ show x ++ "\n"++
                            showst st)
           Just b  -> return b
       }

showst :: St -> String
showst st = unlines [ "GP"    ++ M.showTree (gp st)
                    , "GStar" ++ M.showTree (gstar' st)
                  --  , "uPhi"  ++ M.showTree (uPhi st)
                  --  , "lPhi"  ++ M.showTree (lPhi st)
                    , "listP" ++ M.showTree (listP st)
                    ]

getb :: M.IntMap GBlock -> Label -> GBlock
getb bs n = case M.lookup n bs of
              Nothing -> error "cg:getb"
              Just b  -> b

getChildren :: M.IntMap GBlock -> GBlock -> [GBlock]
getChildren bs b = map (getb bs) (children b)


-------------------------------------------------------------------------------

computeGates :: [GBlock] -> [GBlock]
computeGates bs = runST $
    do { ref <- newSTRef (initial bs)
       ; forM (reverse $ sort bs) $ \b ->
         do derive ref b
            merge ref b
       ; st <- readSTRef ref
       ; trace (showst st) $ return bs
       }

derive :: STRef a St -> GBlock -> ST a ()
derive ref b@(GBlock { label = u }) =
    do { bs <- liftM blocks (readSTRef ref)
       ; forM_ (getChildren bs b) $ \c@(GBlock{ label=v }) ->
           forM_ (cfgpre c) $ \w ->
               if w == u then
                   modifySTRef ref $ \s ->
                   s { gp = M.adjust (`gcup` pe (getb bs w) c) v (gp s) }
               else
                   do (phi,g) <- eval ref (getb bs w) c
                      modifySTRef ref $ \s ->
                       s { listP = M.adjust (g:)     v (listP s)
                         , uPhi  = M.adjust (phi ||) v (uPhi s)
                         }
       }

eval :: STRef a St -> GBlock -> GBlock -> ST a (Bool, Gate)
eval ref bw bv
    | trace ("EVAL "++ show (label bw, label bv)) False = undefined
    | otherwise =
        do { bs <- liftM blocks (readSTRef ref)
           ; let p = subPath bs (idom bv) [] w
           ; g <- liftM (foldl1 gdot) $ mapM getR p
           ; return (True,g `gdot` pe bw bv)
           }
 where
   w = label bw
   v = label bv

   getR x = do { st <- readSTRef ref
               ; let g = fromJust $ M.lookup x (gp st)
               ; --writeSTRef ref st { r = M.insert x g (r st) } -- ??
               ; return g
               }
   --getPhi x = do xP <- getSt "uPhi" ref uPhi x
   --              xp <- getSt "lPhi" ref lPhi x
   --              return (xP || xp)

   --
   subPath bs idv ns n | n == idv  = reverse ns
                       | otherwise = let bn = getb bs n in
                                     subPath bs idv (n:ns) (idom bn)


merge :: STRef a St -> GBlock -> ST a ()
merge ref bu =
    do { let u = label bu
       ; bs <- liftM blocks (readSTRef ref)
       ; forM_ (topsortBlocks (getChildren bs bu)) $ \bv@(GBlock{ label=v }) ->
         getSt "listP" ref listP v >>= \list ->
         forM_ list $ \l ->
         do { if from l == v then
                  modifySTRef ref $ \s ->
                  s { gstar' = M.adjust (`gcup` l) v (gstar' s) }
              else
                  modifySTRef ref $ \s ->
                  let x   = fromJust $ M.lookup (from l) (gp s)
                      y   = x `gdot` l
                      --phi = fromJust $ M.lookup (from l) (uPhi s)
                  in s { gp   = M.adjust (`gcup` y) v (gstar' s)
                      -- , uPhi = M.adjust (phi ||) v (uPhi s)
                       }
            ; update ref bu bv
            ; link ref bu bv
            }
       }

update :: STRef a St -> GBlock -> GBlock -> ST a ()
update ref bu bv
    | trace ("UPDATE "++ show (u,v)) False = undefined
    | otherwise =
        return ()
{-
        do { if idom bu >= 0 then
                 do { idom_u <- getSt "blocks" ref blocks (idom bu)
                    ; if pdom (idom_u) == v
                      then modifySTRef ref $ \s ->
                          s { r = M.insert v (Lambda u v) (r s) }
                      else modifySTRef ref $ \s ->   -- BLEH
                          let p = fromJust $ M.lookup v (gp s) in
                          s { r = M.insert v p (r s) }
                    }
             else modifySTRef ref $ \s -> -- BLEH
                 let p = fromJust $ M.lookup v (gp s) in
                 s { r = M.insert v p (r s) }
           ; return ()
           }
-}
 where
   u = label bu
   v = label bv


link :: STRef a St -> GBlock -> GBlock -> ST a ()
link ref bu bv
    | trace ("LINK "++ show (u,v)) False = undefined
    | otherwise = return ()
 where
   u = label bu
   v = label bv
-}
