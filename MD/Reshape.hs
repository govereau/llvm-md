{-# LANGUAGE PatternGuards #-}
{-|
  Description : Reshape CFGs.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module performs some simple transformations on LLVM CFGs to make the
  rest of the pipeline a little bit nicer.
-}
module MD.Reshape ( reshape ) where
import Data.List
import Data.Maybe

import MD.Syntax.LLVM
import MD.Graph

import Debug.Trace

reshape :: [Block] -> [Block]
reshape bs = oneBackedge $ oneReturn $ nodead bs

-------------------------------------------------------------------------------
-- remove dead code (blocks with no predecessors)

nodead :: [Block] -> [Block]
nodead bs = map vf (rs \\ to_change) ++
            map tr to_change
 where
   entry_v   = fromJust (kf 0) -- ASSUME entry block is numbered zero
   rs        = reachable g entry_v
   dead      = vertices g \\ rs
   to_change = nub (concatMap (suc g) dead) \\ dead
   (g,vv,kf) = graphFromEdges (blockGraph bs)
   vf x      = case vv x of (b,_,_) -> b

   tr v = let b = vf v in
          b { blockMiddle = map tr' (blockMiddle b) }

   tr' (Instruction x (Phi ty arms)) = Instruction x (Phi ty (filter f arms))
   tr' inst = inst

   f (v,l) = l `notElem` dead_lbls
   dead_lbls = concatMap (lbls . vf) dead
   lbls b = [ LI (blockIndex b), LS (blockName b) ]

-------------------------------------------------------------------------------
-- find loops with multiple backedges and make there be only one

oneBackedge :: [Block] -> [Block]
oneBackedge bs = sort bs'
    --if sort bs == sort bs' then bs'
    --else error ("NOT EQUAL\n"++ show (sort bs \\ bs') ++"\n===\n"++
    --            show (sort bs' \\ bs))
 where
   bs' = cycles bs (premap bs) bs

-- map a block to it's predecesors by index (not label)

type PreMap = [(Int, [Int])]

premap :: [Block] -> PreMap
premap bs = [ (blockIndex b, pres b) | b <- bs ]
 where
   pres b = map blockIndex $ filter (isPre b) bs
   isPre b x = any (isP b) (blockTargets x)
   isP b (LI i) = i == blockIndex b
   isP b (LS s) = s == blockName b

cycles :: [Block] -> PreMap -> [Block] -> [Block]
cycles blocks pm bs = f $ stronglyConnComp $ blockGraph bs
 where
   f []               = []
   f (AcyclicSCC b:l) = b : f l
   f (CyclicSCC cs:l) = be blocks pm cs ++ f l

blockGraph :: [Block] -> [(Block, Int, [Int])]
blockGraph bs = [ (b, blockIndex b, map cvt (blockTargets b)) | b <- bs ]
 where
   m = map (\b -> (blockName b, blockIndex b)) bs
   cvt (LI i) = i
   cvt (LS s) = fromJust (lookup s m)

be :: [Block] -> PreMap -> [Block] -> [Block]
be blocks pm bs = case partition pre_in bs of
  (bs1,[x]) -> let (entry,bes) = case partition (`elem` qs) (preds x) of
                                   (yy,[x]) -> (x, yy)
                                   (_,xs) -> error ("loop has "++ show (length xs) ++ " in edges")
               in
               if length bes == 1
               then x:cycles blocks pm bs1
               else merge blocks entry bes x (cycles blocks pm bs1)
  (_,l) -> error ("loop has " ++ show (length l) ++ " entries")
 where
   qs       = map blockIndex bs
   pre_in b = all (`elem` qs) (preds b)
   preds  b = fromJust $ lookup (blockIndex b) pm

-- merge back edges

merge :: [Block] -> Int -> [Int] -> Block -> [Block] -> [Block]
merge blocks entry bes header bs =
    header { blockMiddle = tr1 0 (blockMiddle header)
           } : newB : map change bs
 where
   entryb = getb blocks entry
   entryName = blockName entryb
   qs = map blockIndex (header:bs)

   newL = LI $ blockIndex newB
   newB = (newBlock blocks) { blockEnd    = Br (LI $ blockIndex header)
                            , blockMiddle = tr2 0 (blockMiddle header)
                            }
   newVs = [ Ident ("pm"++ show v) | v <- [blockIndex newB ..] ]
   newArm k = (Var (newVs !! k), LI $ blockIndex newB)

   change :: Block -> Block
   change b = b { blockEnd = case blockEnd b of
                               Br l | isHeader l -> Br newL
                               CBr v l1 l2
                                   | isHeader l1 -> CBr v newL l2
                                   | isHeader l2 -> CBr v l1 newL
                               Switch tv l arms
                                   | isHeader l -> Switch tv newL arms
                                   | otherwise  -> Switch tv l (map ch arms)
                               x -> x
                }
   ch (tv,l) | isHeader l = (tv, newL)
             | otherwise  = (tv, l)

   tr1 _ [] = []
   tr1 k (Instruction x (Phi ty arms):l) =
          Instruction x (Phi ty (trim arms++[newArm k])) : tr1 (k+1) l
   tr1 k (i:l) = i : tr1 k l

   tr2 _ [] = []
   tr2 k (Instruction _x (Phi ty arms):l) =
          Instruction (Just (newVs !! k)) (Phi ty (untrim arms)) : tr2 (k+1) l
   tr2 k (_:l) = tr2 k l

   untrim = filter (\(_,l) -> not $ isEntry l)
   trim = filter (\(_,l) -> isEntry l)
   isEntry l = case l of
                  LI i -> i == entry
                  LS s -> s == entryName
   isHeader l = case l of
                  LI i -> i == blockIndex header
                  LS s -> s == blockName header

--shbks bs = unlines $
--           map (\b -> show (preds bs b) ++ show b) $
--           sortBy (\x y -> compare (blockIndex x) (blockIndex y)) bs


getb :: [Block] -> Int -> Block
getb bs i = fromJust $ find (\b -> blockIndex b == i) bs

-------------------------------------------------------------------------------
-- build a new return node for functions with multiple returns.

oneReturn :: [Block] -> [Block]
oneReturn bs | length rbs == 1 = bs
             | otherwise       = bs' ++ rbs' ++ [blk]
 where
   (rbs,bs') = partition hasRet bs
   hasRet b = case blockEnd b of
                Return _    -> True
                Unreachable -> True
                _           -> False
   getRet b = case blockEnd b of
                Return x    -> (blockIndex b,x)
                Unreachable -> (blockIndex b,Nothing)
                _           -> error "getRet"

   rbs' = map (trans $ blockIndex blk) rbs
   (ins, ret) = merger $ map getRet rbs

   blk' = newBlock bs
   blk  = blk' { blockMiddle = ins
               , blockEnd    = ret
               }

trans :: Int -> Block -> Block
trans l b = b { blockEnd = Br (LI l) }

newBlock :: [Block] -> Block
newBlock bs = let ndx = maximum (map blockIndex bs) + 1
              in Block (show ndx) ndx [] Unreachable

merger :: [(Int,Maybe TV)] -> (Instructions, ControlInst)
merger mvs = ([i], Return (Just v))
 where
   n = Ident "MRET"
   i = Instruction (Just n) (Phi ty arms)
   v = TV ty (Var n)

   ty = findTy mvs
   findTy [] = Void
   findTy ((_,Nothing):xs) = findTy xs
   findTy ((_,Just (TV t _)):_) = t

   arms = map arm mvs
   arm (a,(Just (TV _ b))) = (b, LI a)
   arm (a,Nothing) = (Const Undef, LI a)
