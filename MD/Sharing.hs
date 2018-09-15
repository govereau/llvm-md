{-# OPTIONS -fno-warn-orphans #-}
{-# LANGUAGE GADTs, PatternGuards #-}
{-|
  Description : Sharing implmentation.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module implements sharing by computing a graph representation of a
  symbolic value from a set of rewrite rules.
-}
module MD.Sharing
  ( ValueGraph, changed, emptyGraph, gSize
  , uniqueKeys, alist
  , findReturns, countReturns
   --
  , findByKey, fetchVal
  , findByValue, fetchKey
   --
  , insertValue, alterValue, replaceValue
  , graphize
  , gMin
  , partIO, partGraph
  )
where
import Prelude hiding (EQ)
import Control.Monad hiding (mapM)
import Control.Monad.ST
import Control.Applicative
import Data.Traversable
import Data.List
import Data.Maybe
import Data.STRef
import qualified Data.Map as M
import qualified Data.IntMap as IM
import qualified Data.IntSet as S

import MD.Graph
import MD.Syntax.GDSA

--import Debug.Trace
--trace _ x = x

-------------------------------------------------------------------------------
-- value graphs

data ValueGraph = VG { changed :: Bool            -- have new nodes been added
                     , ss      :: [(Int,Int)]     -- replaced nodes since gMin
                     , returns :: [Int]           -- pointers to return nodes
                     , nextkey :: Int             -- next key value to use
                     , keymap  :: IM.IntMap Value -- the actual graph
                     , valmap  :: M.Map Value Int -- lookup for value pointers
                     }

instance Show ValueGraph where
    show vg = show (ss vg) ++"\n"++
              (unlines $ flip map (alist vg) $ \(u,v) ->
              show u ++ " -> "++ show v)

emptyGraph :: ValueGraph
emptyGraph = VG False [] [] 0 IM.empty M.empty


gSize :: ValueGraph -> Int
gSize vg = IM.size (keymap vg)

-------------------------------------------------------------------------------
-- query

uniqueKeys :: ValueGraph -> [Int]
uniqueKeys vg = IM.keys (keymap vg) \\ map fst (ss vg)

alist :: ValueGraph -> [(Int,Value)]
alist = IM.toList . keymap

findReturns :: ValueGraph -> [Int]
findReturns vg = nub $ map (s (ss vg)) (returns vg)

countReturns :: ValueGraph -> Int
countReturns vg = length $ nub $ map f $ findReturns vg
 where
   f u = sv (ss vg) (fetchVal vg u)

findByKey :: ValueGraph -> Int -> Maybe Value
findByKey vg x = IM.lookup (s (ss vg) x) (keymap vg)

fetchVal :: ValueGraph -> Int -> Value
fetchVal vg u = case findByKey vg u of
  Nothing -> error ("fetchVal:"++ show u)
  Just x  -> x

findByValue :: ValueGraph -> Value -> Maybe Int
findByValue vg v = M.lookup v (valmap vg)

fetchKey :: ValueGraph -> Value -> Int
fetchKey vg v = case findByValue vg v of
  Nothing -> error ("fetchKey:"++ show v)
  Just x  -> x

-------------------------------------------------------------------------------
-- modifiers with sharing

insertValue :: Value -> ValueGraph -> (ValueGraph,Int)
insertValue v vg@(VG { nextkey = next }) =
  case findByValue vg v of
    Just x  -> (vg, x)
    Nothing -> ((insertValueAt next v vg) { nextkey = next + 1 }, next)

insertValueAt :: Int -> Value -> ValueGraph -> ValueGraph
insertValueAt u v vg@(VG _ _ rs _ km vm) =
    vg { changed = True
       , returns = case v of { CV (Returns _) -> nub (u:rs); _ -> rs }
       , keymap  = IM.insert u v km
       , valmap  = M.insert v u vm
       }

deleteKey :: Int -> ValueGraph -> ValueGraph
deleteKey u vg = case IM.lookup u (keymap vg) of
  Nothing  -> vg
  Just val -> vg { ss      = sdel u (ss vg)
                 , returns = filter (/=u) (returns vg)
                 , keymap  = IM.delete u (keymap vg)
                 , valmap  = M.delete val (valmap vg)
                 }

alterValue :: Int -> Value -> ValueGraph -> ValueGraph
alterValue u new vg = case findByValue vg new of
  Nothing -> insertValueAt u new (deleteKey u vg)
  Just u' -> replaceValue u u' vg

replaceValue :: Int -> Int -> ValueGraph -> ValueGraph
replaceValue a b valgr =
    let vg@(VG { ss = l, keymap = km }) = deleteKey a valgr in
    vg { changed = True
       , ss      = (a,b) @@ l
       , keymap  = IM.insert a (fetchVal vg b) km
       }

-------------------------------------------------------------------------------
-- substitution on values

sv :: [(Int,Int)] -> Value -> Value
sv m term = case term of
  Param _          -> term
  Memory cs        -> Memory $ map cell cs
  CV (Phi ty arms) -> CV (Phi ty (sort $ nub $ map arm arms))
  CV v             -> CV (fmap f v)
 where
   f = s m
   arm (PhiArm gs v) = PhiArm (sort $ nub $ map f gs) (f v)
   cell (Cell ty n pp pv) = Cell ty n (f pp) (f pv)

s :: [(Int,Int)] -> Int -> Int
s m x = case lookup x m of
          Nothing -> x
          Just y  -> y

(@@) :: (Int,Int) -> [(Int,Int)] -> [(Int,Int)]
(a,b) @@ l | a == b    = l
           | otherwise = (a,s l b) : sdel a (map ab l)
 where
   ab (x,y) | y == a    = (x,b)
            | otherwise = (x,y)

sdel :: Int -> [(Int,Int)] -> [(Int,Int)]
sdel u l = filter (\p -> fst p /= u) l

-------------------------------------------------------------------------------
-- internal state

type State a = ( STRef a ValueGraph , [(Ident,Int)] )

newState :: ValueGraph -> ST a (State a)
newState vg =
    do { d <- newSTRef vg
       ; return (d,[])
       }

stateToVG :: State a -> ST a ValueGraph
stateToVG st = readSTRef (fst st)

addIdent :: Ident -> Int -> State a -> State a
addIdent i u (d,m) = (d, (i,u) : m)


graphize :: ValueGraph -> [RR] -> ValueGraph
graphize vg rr' = runST $
    do { st0 <- newState vg
       ; st1 <- graphize' st0 (postorderRules rr')
       ; vg' <- stateToVG st1
       ; return $ foldl (tr $ snd st1) vg' (uniqueKeys vg')
       }
 where
   graphize' :: State a -> [RR] -> ST a (State a)
   graphize' st [] = return st
   graphize' st (RR ident term:rr) =
       do { u <- mkNodes st term
          ; graphize' (addIdent ident u st) rr
          }

   tr m g u
       | Param i <- fetchVal g u
       , Just u' <- lookup i m    = replaceValue u u' g
       | otherwise                = g


instance Applicative (ST a) where
    pure  = return
    (<*>) = ap

mkNodes :: State a -> Term -> ST a Int
mkNodes st (Var i)         = hcons st (Param i)
mkNodes st (CT term)       = do v <- traverse (mkNodes st) term
                                hcons st (CV v)

hcons :: State a -> Value -> ST a Int
hcons (_,m) (Param i) | Just u <- lookup i m = return u
hcons (r,_) v =
    do { vg <- readSTRef r
       ; let (vg',u) = insertValue v vg
       ; writeSTRef r vg'
       ; return u
       }

-------------------------------------------------------------------------------
-- remove unused rules

gMin :: ValueGraph -> ValueGraph
gMin vg = vg2 { changed = False }
 where
   vg1  = sharing vg
   vg2  = vg1
   --vg2  = foldl (\g u -> deleteKey u g) vg1 (ks \\ used)
   --ks   = uniqueKeys vg1
   --used = findU vg1 [] (findReturns vg1)
{-
findU :: ValueGraph -> [Int] -> [Int] -> [Int]
findU _  seen [] = seen
findU vg seen vs = findU vg (vs ++ seen) (cs \\ seen)
 where
   vals = map (fetchVal' vg) vs
   cs   = foldl1 union $ map refs vals

fetchVal' :: ValueGraph -> Int -> Value
fetchVal' vg u = case findByKey vg u of
  Nothing -> error ("fetchVal':"++ show u)
  Just x  -> x
-}

-------------------------------------------------------------------------------
-- sharing entry point

sharing :: ValueGraph -> ValueGraph
sharing vg0 | null ss0, null ss1 = vg0 { changed = False }
            | otherwise          = sharing vg2
 where
   ss0 | null (ss vg0) = dups vg0
       | otherwise     = ss vg0
   vg1 = substGraph ss0 vg0 { ss = [] }
   ss1 = foldr (@@) [] $ shareCycles (alist vg1)
   vg2 = substGraph ss1 vg1

dups :: ValueGraph -> [(Int,Int)]
dups vg = f (uniqueKeys vg)
 where
   f []     = []
   f (u:us) = let u' = fetchKey vg (fetchVal vg u) in
              if u == u' then f us
              else (u,u') : f us

-- apply pointer substitutions

substGraph :: [(Int,Int)] -> ValueGraph -> ValueGraph
substGraph [] vg = vg
substGraph m  vg =
    vg' { keymap = km'
        , valmap = vm'
        }
 where
   vg'@(VG { keymap = km }) = foldl (\g (x,_) -> deleteKey x g) vg m
   km' = IM.map (sv m) km
   vm' = M.fromList (map swap $ IM.toList km')
   swap (a,b) = (b,a)

-------------------------------------------------------------------------------
-- cycle sharing

type Node = (Int,Value)

shareCycles :: [Node] -> [(Int,Int)]
shareCycles ns = concat $ mapMaybe (traceCycle ns []) $ findCyclePairs ns

findCyclePairs :: [Node] -> [(Int,Int)]
findCyclePairs ns = poss ns
 where
   poss []     = []
   poss (m:ms) =
       case m of
         (u, CV (Mu _ty z _)) ->
             let xs = map fst $ fst $ partition (p z) ms in
             zip (repeat u) xs ++ poss ms
         _ -> poss ms
   p z (_, CV (Mu _ z' _)) = z' == z
   p _ _ = False

traceCycle :: [Node] -> [(Int,Int)] -> (Int,Int) -> Maybe [(Int,Int)]
traceCycle ns sl (n1,n2)
    | n1 == n2                 = Just sl
    | sub n1 == n2             = Just sl
    | n1 `elem` map fst sl     = Nothing
    | valname v1 /= valname v2 = Nothing
    | Just ss <- match v1 v2   = foldM (traceCycle ns) ((n1,n2):sl) ss
    | otherwise                = Nothing
 where
   v1  = fetch n1
   v2  = fetch n2
   sub x = case lookup x sl of { Just y -> y; _ -> x }
   fetch p = case lookup p ns of
               Nothing -> error ("traceCycle fetch "++ show p)
               Just v  -> v

match :: Value -> Value -> Maybe [(Int,Int)]
match (CV (Phi t a)) (CV (Phi t' a')) | t == t'   = pmatcher a a'
                                      | otherwise = Nothing
match v1 v2 =
    let r1 = refs v1 in
    let r2 = refs v2 in
    if length r1 == length r2
    then Just $ zip (refs v1) (refs v2)
    else Nothing

pmatcher :: [PhiArm Int] -> [PhiArm Int] -> Maybe [(Int,Int)]
pmatcher [] [] = Just []
pmatcher l1 l2 | length l1 /= length l2 = fail ""
pmatcher l1 l2 = f [] l2 l1
 where
   f r [] [] = return r
   f r l (x:xs) = case partition (sim x) l of
                    ([],_)      -> fail ""
                    ((y:l1),l2) -> f (subs x y ++ r) xs (l1++l2)


   sim  (PhiArm g1 x) (PhiArm g2 y) = sort g1 == sort g2 && x == y
   subs (PhiArm g1 x) (PhiArm g2 y) =
       let l1 = x:sort g1 in
       let l2 = y:sort g2 in
       let i  = intersect l1 l2 in
       let r1 = l1 \\ i in
       let r2 = l2 \\ i in
       zip r1 r2


-------------------------------------------------------------------------------
-- simple implementation of partitioning.

data Class = Class { classname :: String
                   , members   :: S.IntSet
                   , nodes     :: [Node]
                   }

instance Eq Class where
    c1 == c2 = classname c1 == classname c2 &&
               members c1 == members c2

instance Show Class where
    show c = classname c ++ show (S.toList $ members c)
    showList l _  = unlines (map ((' ':)) (sort $ map show l))

getValue :: Node -> Value
getValue = snd

getKey :: Node -> Int
getKey = fst

isMember :: Int -> Class -> Bool
isMember x c = S.member x (members c)

--- entry point


partGraph :: ValueGraph -> Maybe ValueGraph
partGraph vg =
    let cs = part (initial (alist vg)) in
    case find (\c -> length (nodes c) > 1) cs of
      Nothing -> Nothing
      Just _  ->
          let ss = gets [] cs in
          let vs = getv ss cs in
          Just VG { changed = False
                  , ss      = []
                  , returns = map (s ss) (returns vg)
                  , nextkey = maximum (map fst ss) + 1
                  , keymap  = IM.fromList vs
                  , valmap  = M.fromList $ map (\(x,y) -> (y,x)) vs
                  }
 where
   gets s []     = s
   gets s (c:cs) = case c of
                     Class { nodes = []   } -> gets s cs
                     Class { nodes = n:ns } ->
                         let new_s = foldl (\s' x -> (getKey x, getKey n) @@ s') s ns
                         in gets new_s cs

   getv _ []    = []
   getv s (c:l) =
       let (u,v) = head (nodes c) in (u, sv s v) : getv s l

partIO :: ValueGraph -> IO ()
partIO vg =
    do { let ns = alist vg
       ; putStrLn "\nCLASSES"
       ; print $ filter (\c -> length (nodes c) /= 1) $ part (initial ns)
       }

initial :: [Node] -> [Class]
initial = foldl cls []
 where
   cls cs n@(u,v) =
       case partition (\c -> classname c == valname v) cs of
         ([],_)    -> Class (valname v) (S.singleton u) [n] : cs
         ([c],cs') -> c { members = S.insert u (members c)
                        , nodes = n : nodes c
                        } : cs'
         _ -> error "bad classes"

part :: [Class] -> [Class]
part cs = if length cs /= length cs' then part cs' else cs'
 where
   cs' = concatMap p cs

   p (Class { nodes = []})       = []
   p c@(Class { nodes = [n]})    = [c]
   p c@(Class { nodes = (n:ns)}) =
       case partition (cong n) ns of
         (a,b) -> c { members = S.fromList (map getKey (n:a))
                    , nodes = n:a
                    } :
                  p c { members = S.fromList (map getKey b)
                      , nodes = b
                      }

   cong (_,CV (Phi t a)) (_,CV (Phi t' a'))
       | t == t' = matcher (curry cong') a a'
   cong n1 n2 =
       let r1' = refs (getValue n1) in
       let r2' = refs (getValue n2) in
       --let is  = intersect r1' r2' in
       let r1 = r1' in -- \\ is in
       let r2 = r2' in -- \\ is in
       if length r1 == length r2
       then all cong' (zip r1 r2)
       else False

   cong' (i1,i2) = cls i1 == cls i2
   cls i = case find (isMember i) cs of
             Nothing -> error ("no calss for "++ show i)
             Just x  -> x
--   f i (Class ns) = i `elem` map getKey ns

matcher :: (Int -> Int -> Bool) -> [PhiArm Int] -> [PhiArm Int] -> Bool
matcher _  [] [] = True
matcher _  l1 l2 | length l1 /= length l2 = False
matcher eq l1 l2 = all (uncurry byrd) todo
 where
   byrd []     _    = True
   byrd (a:ax) poss = case partition (match a) poss of
                        ([], _)  -> False
                        ([_],ps) -> byrd ax ps
                        (xs,ps)  -> {-byrd ax (tail xs++ps) -} try ax xs ps

   try _ax [] _    = False
   try ax (y:ys) l = if byrd ax (ys++l) then True
                     else try ax ys (y:l)

   match (PhiArm g1 _) (PhiArm g2 _) =
       all (\x -> isJust (find (eq x) g2)) g1

   todo = map (\ss -> (ss, similar (head ss) l2)) (ssets l1)

   ssets []     = []
   ssets (x:xs) = let (withx,other) = simSplit x xs
                  in (x:withx) : ssets other

   similar x l = fst $ simSplit x l
   simSplit x l = partition (sim x) l
   sim (PhiArm g1 x) (PhiArm g2 y) = length g1 == length g2 && eq x y
