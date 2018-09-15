{-# LANGUAGE GADTs, PatternGuards #-}
{-|
  Description : Sharing implmentation.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module implements sharing by computing a graph representation of a
  symbolic value from a set of rewrite rules.
-}
module MD.Partitioning where
import Data.List
import Data.Maybe
import MD.Syntax.GDSA
import MD.Sharing

-- silly n^2 or worse implementation of partitioning.

type Node = (Int,Value)
data Class = Class { members :: [Node] }
             deriving Eq

instance Show Class where
    show c = classname c ++ show (nodes c)
    showList l _  = unlines (map ((' ':)) (sort $ map show l))

getValue :: Node -> Value
getValue = snd

getKey :: Node -> Int
getKey = fst

classname :: Class -> String
classname (Class l) = valname (getValue $ head l)

nodes :: Class -> [Int]
nodes c = map getKey (members c)

-------------------------------------------------------------------------------

partIO :: ValueGraph -> IO ()
partIO vg =
    do { let ns = alist vg
       ; putStrLn "\nCLASSES"
       ; print $ initial ns
       ; putStrLn "\nCLASSES"
       ; print $ filter (\c -> length (members c) /= 1) $ part (initial ns)
       }

initial :: [Node] -> [Class]
initial = foldl cls []
 where
   cls cs n@(_,v) =
       case partition (\c -> classname c == valname v) cs of
         ([],_)           -> Class [n]:cs
         ([Class ns],cs') -> Class (n:ns):cs'
         _                -> error "bad classes"

part :: [Class] -> [Class]
part cs = if length cs /= length cs' then part cs' else cs'
 where
   cs' = concatMap p cs

   p (Class [])     = []
   p (Class [n])    = [Class [n]]
   p (Class (n:ns)) = case partition (cong n) ns of
                        (a,b) -> Class (n:a) : p (Class b)

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
   cls i = find (f i) cs
   f i (Class ns) = i `elem` map getKey ns

matcher :: (Int -> Int -> Bool) -> [PhiArm Int] -> [PhiArm Int] -> Bool
matcher _  [] [] = True
matcher _  l1 l2 | length l1 /= length l2 = False
matcher eq l1 l2 = all (uncurry byrd) todo
 where
   byrd []     _    = True
   byrd (a:ax) poss = case partition (match a) poss of
                        ([], _)  -> False
                        ([_],ps) -> byrd ax ps
                        (xs,ps)  -> try ax xs ps

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
