{-# LANGUAGE PatternGuards #-}
{-|
  Description : Structural analysis.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Implementation of Structural Analysis following M. Sharir (1980) and C.
  Cifuentes (1993, 1996).
-}
module MD.Structural
  ( BasicBlock(..), Structure(..)
  , structuralAnalysis, sflatten
  )
where
import Control.Monad
import Data.List
import Data.Tree
import MD.Graph
import MD.Syntax.GDSA
import System.IO

-------------------------------------------------------------------------------
-- abstractions

class Show a => BasicBlock a where
    targets  :: a -> [Label]
    name     :: a -> Label
    children :: a -> [Label]
    children x = [name x]

instance BasicBlock GBlock where
    targets b  = suc' b
    name b     = label b

-------------------------------------------------------------------------------
-- Structure language

data Structure a
   = Empty
   | Single a
   | Sequence [Structure a]
   | If [a] (Structure a) (Structure a)
   | IfN a [Structure a]
   | WhileLoop a (Structure a)

instance BasicBlock a => Show (Structure a) where
    show Empty           = "E"
    show (Single s)      = show (name s)
    show (Sequence ss)   = show ss
    show (If cs x y)     = "If"++show (map name cs) ++ show (x,y)
    show (IfN c bs)      = "IfN "++ show (name c) ++ show bs
    show (WhileLoop c b) = "While "++ show (name c) ++ show b

instance BasicBlock a => BasicBlock (Structure a) where
    targets  = targets'
    name     = name'
    children = children'

targets' :: BasicBlock a => Structure a -> [Label]
targets' s = case s of
  Empty            -> []
  Single x         -> targets x
  Sequence ss      -> targets (last ss)
  If _ x y         -> targets x `union` targets y
  IfN _c l         -> nub (concatMap targets l)
  WhileLoop c b    -> (targets c `union` targets b) \\ [name c, name b]

name' :: BasicBlock a => Structure a -> Label
name' s = case s of
  Empty            -> 0
  Single x         -> name x
  Sequence ss      -> name (head ss)
  If cs _ _        -> name (head cs)
  IfN c _          -> name c
  WhileLoop c _    -> name c

children' :: BasicBlock a => Structure a -> [Label]
children' s = case s of
  Empty            -> []
  Single x         -> children x
  Sequence ss      -> nub $ concatMap children ss
  If cs x y        -> nub $ concatMap children cs ++ children x ++ children y
  IfN c l          -> nub $ children c ++ concatMap children l
  WhileLoop c b    -> nub $ children c ++ children b

sflatten :: Structure a -> [a]
sflatten s = case s of
  Empty            -> []
  Single x         -> [x]
  Sequence ss      -> concatMap sflatten ss
  If cs x y        -> cs ++ sflatten x ++ sflatten y
  IfN c l          -> c : concatMap sflatten l
  WhileLoop c b    -> c : sflatten b

-------------------------------------------------------------------------------
-- The analysis algorithm

structuralAnalysis :: BasicBlock a => [a] -> IO (Structure a)
structuralAnalysis bs = loop 1 0 [ Single b | b <- bs ]

loop :: BasicBlock a => Int -> Int -> [Structure a] -> IO (Structure a)
loop _ _ [s] = return s
loop j k ss' =
    do { let ss = case partition (\x -> name x == 0) ss' of
                    ([],_)  -> error "lost entry node"
                    ([e],l) -> e:l
                    (es,l ) -> last (sortBy (\x y -> compare (show x) (show y)) es) : l
       ; let nodes = [ (s, name s, targets s) | s <- ss ]
       ; let (g,vf,_k) = graphFromEdges nodes
       ; let ~[dfst]   = dfs g [0]
       ; let vs        = reverse (flatten dfst)
       ; --putStr $ drawTree $ toStr vf dfst
       ; --writeStep j g $ \v -> case vf v of (s,_,_) -> show s
       ; let vs' = go g vf vs
       ; --
       ; if length vs == length vs'
         then if k < 50
              then loop (j+1) (k+1) $ map snd vs'
              else do { --mapM_ (\(v,_) -> putStrLn (show v++show(pre g v)++ show(suc g v))) vs'
                      ; fail "stalled"
                      }
         else loop (j+1) k $ map snd vs'
       }

writeStep :: Int -> Graph -> (Vertex -> String) -> IO ()
writeStep j g vf =
    do { h <- openFile ("step"++ show j ++ ".dot") WriteMode
       ; hPutStrLn h $ "digraph step"++show j++" {\nmargin=\"0\"\nsize =\"8.5,11.0\"\n"
       ; forM_ (vertices g) $ \v -> hPutStrLn h (show v++ "[label="++ show (vf v) ++"]")
       ; forM_ (edges g) $ \(v1,v2) -> hPutStrLn h (show v1 ++ " -> "++ show v2)
       ; hPutStrLn h "}"
       ; hClose h
       }

{-  #  NOINLINE gtr #-}
--gtr :: Show a => a -> Bool
--g-tr x = trace (show x) True

{-  - # NOINLINE tr #-}
--tr :: Show a => a -> a
--tr x = trace (show x) x

go :: BasicBlock node => Graph
   -> (Vertex -> (Structure node, key, [key]))
   -> [Vertex] -> [(Vertex,Structure node)]
go g vf vtxs = f [] vtxs
 where
   --f :: [(Vertex,Structure node)] -> [Vertex] -> [Structure node]
   f used []     = used
   f used (v:vs) = f ((v,anl used v):used) vs
   anl used v =
       let node x = case lookup x used of
                      Just s -> s
                      Nothing -> case vf x of (n,_,_) -> n in
       let mnode False _ = Empty
           mnode True x = node x in
       let node' x = case node x of
                       Single b -> b
                       s -> error ("node' "++ show s) in
       case suc g v of
         [v']    | pre g v' == [v], length (suc g v') <= 1 -> sq (node v) (node v')
         [v1,v2] | v1 == v -> WhileLoop (node' v) Empty
                 | v2 == v -> WhileLoop (node' v) Empty
         [v1,v2] | suc g v1 == [v], suc g v2 /= [v] -> WhileLoop (node' v) (node v1)
                 | suc g v2 == [v], suc g v1 /= [v] -> WhileLoop (node' v) (node v2)
         [v1,v2] | Just (cs,hf) <- halfbat g v v1 v2 -> If (map node' cs) (node v1) (mnode hf v2)
                 | Just (cs,hf) <- halfbat g v v2 v1 -> If (map node' cs) (node v2) (mnode hf v1)
         (v1:vs) | [exit] <- suc g v1,
                   all (\v' -> suc g v' == [exit]) vs,
                   all (\v' -> pre g v' == [v]) (v1:vs)
                 -> IfN (node' v) (map node (v1:vs))
         _ -> node v

-- look for a half-bat with last test at v, the true branch at tv, and
-- the false branch at fv. Returns the list of conditional nodes, the
-- a flag indicating is the false branch exists.

halfbat :: Graph -> Vertex -> Vertex -> Vertex -> Maybe ([Vertex],Bool)
halfbat g v tv fv =
  case (suc g tv, suc g fv) of
    ([e1],[e2]) | e1 == e2 -> case (wing tv, wing fv) of
                                (xs,ys) | length xs > length ys -> Just (xs,True)
                                        | length xs < length ys -> Just (ys,True)
                                        | length xs == 1        -> Just (xs,True)
                                        | otherwise             -> error "bad wing"
    ([exit],_)  | exit == fv -> Just (wing tv, False)
    _ -> Nothing
 where
   wing  body   = reverse (chase body v)
   chase body x = case pre g x of
                    [y] -> case suc g y of
                             [a,b] | a == body -> x : chase body y
                                   | b == body -> x : chase body y
                             _ -> [x]
                    _ -> [x]

sq :: Structure a -> Structure a -> Structure a
sq a b = Sequence (f a ++ f b)
 where
   f (Empty)      = []
   f (Sequence l) = l
   f x            = [x]


toStr :: (BasicBlock a)
      => (Vertex -> (Structure a, Label, [Label])) -> Tree Vertex -> Tree String
toStr vf (Node v sf) =
    let s = show v ++":"++ show (let (x,_,_) = vf v in x) in
    Node s (map (toStr vf) sf)
