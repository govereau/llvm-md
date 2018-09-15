{-# LANGUAGE PatternGuards #-}
{-|
  Description : Convert basic blocks to GDSA form.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module builds a CFG of GDSA rules from an SSA program, by converting
  each basic block. This module also generates the abstract state variables
  for side-effects.
-}
module MD.Convert ( convertToGDSA ) where
import Data.List
import Data.STRef
import Control.Monad.ST

import qualified MD.Syntax.LLVM as LL
import MD.Syntax.LLVM hiding (Label(..), MemoryInst(..), Call, Expr(..), Value(..), Phi)
import MD.Syntax.GDSA
import MD.Graph hiding (pre)

--import Debug.Trace

-- | Convert a set of LLVM Blocks to GDSA GBlocks.

convertToGDSA :: [Block] -> [GBlock]
convertToGDSA bs =
    domTree $
    --addPDom $ addPDoms $
    addIDom $ addDoms $
    addPrePhi $
    runST $
    do { ref1 <- newSTRef 0
       ; ref2 <- newSTRef 0
       ; mapM (gblock trans ref1 ref2) bs
       }
 where
   al = map (\b -> (blockName b, blockIndex b)) bs
   trans (LL.LI i) = i
   trans (LL.LS s) = case lookup s al of
                       Just n  -> n
                       Nothing -> error "invalid label name"

domTree :: [GBlock] -> [GBlock]
domTree blocks = map trans blocks
 where
   trans b = b { children = map label [ x | x <- blocks, label b == idom x ] }

-- The final step of the conversion process computes the dominators for each
-- node. These are not very efficient, but it doesn't seem to matter too
-- much.

addPDom :: [GBlock] -> [GBlock]
addPDom = addIDoms' (\b x -> b { pdom = x}) pdoms cfgsuc

addIDom :: [GBlock] -> [GBlock]
addIDom = addIDoms' (\b x -> b { idom = x}) doms cfgpre

addIDoms' :: (GBlock -> Int -> GBlock)
          -> (GBlock -> [Label])
          -> (GBlock -> [Label])
          -> [GBlock] -> [GBlock]
addIDoms' set get next blocks = map trans blocks
 where
   trans b = case get b \\ [label b] of
               [] -> b
               xs -> set b $ findid xs (next b)

   findid [x] _ = x
   findid ds [] = head ds
   findid ds ls =
       case filter (`elem` ds) ls of
         []    -> findid ds (next $ getb $ head ls)
         (x:_) -> x

   getb l = case find (\b -> label b == l) blocks of
              Nothing -> error "addIDoms block not found"
              Just b -> b

addPDoms :: [GBlock] -> [GBlock]
addPDoms bs = addDoms' (\b ls -> b { pdoms = ls }) pdoms cfgsuc
              (postorderBlocks bs)

addDoms :: [GBlock] -> [GBlock]
addDoms bs = addDoms' (\b ls -> b { doms = ls }) doms cfgpre
             (topsortBlocks bs)

addDoms' :: (GBlock -> [Label] -> GBlock)
         -> (GBlock -> [Label])
         -> (GBlock -> [Label])
         -> [GBlock] -> [GBlock]
addDoms' set get next blocks = dom False [] $ map initial blocks
 where
   labels    = map label blocks
   initial b = set b labels

   getb bs l = case find (\b -> label b == l) bs of
                 Nothing -> error "addDoms block not found"
                 Just b -> b
   pre_doms bs b = map (get . getb bs) (next b \\ [label b])

   intersection [] = []
   intersection l  = foldl1 intersect l

   dom changed l [] | changed   = dom False [] (reverse l)
                    | otherwise = l
   dom changed l (b:bs) =
       let new_set = sort $ nub $ label b : intersection (pre_doms (l++bs) b) in
       if get b /= new_set
       then dom True (set b new_set : l) bs
       else dom changed (b:l) bs

-- After we have a set of gblocks, this function adds the meta-data including
-- the memory variables assignments, memory phi data, and the block
-- predecessors.

addPrePhi :: [GBlock] -> [GBlock]
addPrePhi bs = dfns $ map proc $ map addpre bs
 where
   addpre b = b { cfgpre = pre (label b) }
   pl    = [ (n,ns)  | b <- bs, let n = label b, let ns = prl n ]
   prl n = [ label b | b <- bs, n `elem` (cfgsuc b) ]
   pre n = case lookup n pl of
             Just ps -> ps
             Nothing -> error "invalid block index"

   proc b = case cfgpre b of
              []  -> b
              [n] -> b { rules = sgl b n : rules b }
              l   -> b { phis  = phi b l : phis  b }
   mid n   = Ident ('$':show n)
   sgl b n = RR (mid $ mem_in b) (snd $ node n)
   phi b l = (mid $ mem_in b, ST, map node l)
   node n  = (n, Var $ mid $ mem_out $ findB n)
   findB n = case find (\x -> n == label x) bs of
               Just b -> b
               Nothing -> error "no block with label"

   dfns l = zipWith (\b n -> b { dfn = n }) (dfoBlocks l) [1..] -- by Jess

-------------------------------------------------------------------------------
-- This is the first conversion function. We run under the ST monad so we can
-- generate fresh variable names.

gblock :: (LL.Label -> Label) -> STRef s Int -> STRef s Int -> Block -> ST s GBlock
gblock trans ref fref b =
    do { x <- readSTRef ref; writeSTRef ref (x+1)
       ; let m_in = x+1
       ; let (px,ix) = span isPhi (blockMiddle b)
       ; rx <- mapM rr ix
       ; m_out <- readSTRef ref; writeSTRef ref (m_out + 2) -- possible return
       ; let (cn,rt) = case cont (blockEnd b) of
                         Ret t -> let mi = Ident ('$':show m_out)
                                      ri = Ident ('R':show (m_out+1))
                                  in ( Ret (Var ri)
                                     ,[ RR ri (CT $ Returns (t, Var mi))])
                         c     -> (c, [])
       ; return $
         GBlock { label      = blockIndex b
                , loopHeader = Nothing    -- computed later
                , phis       = map phi px
                , etas       = []
                , rules      = concat rx ++ rt
                , cfgpre     = []         -- filled in later
                , cfgsuc     = map trans $ blockTargets b
                , dfn        = -1
                , doms       = []
                , idom       = -1
                , pdoms      = []
                , pdom       = -1
                , children   = []
                , mem_in     = m_in
                , mem_out    = m_out
                , control    = cn
                }
       }
 where
   isPhi (Instruction _ (LL.Phi _ _)) = True
   isPhi _ = False
   phi ~(Instruction (Just x) (LL.Phi t l)) = (x,t,map tr l)
   tr (x,l) = (trans l, val x)

   it x = Ident ('$': show x)
   curm = do { old <- readSTRef ref ; return (it old) }
   newm = do { old <- readSTRef ref ; writeSTRef ref (old+1)
             ; return (it old, it (old+1))
             }
   fresh = do { n <- readSTRef fref; writeSTRef fref (n+1)
              ; return (Ident $ '#':show n)
              }
   rr (Instruction Nothing  i) = newm >>= \x -> return (mem x i)
   rr (Instruction (Just x) i) = rhs x i

   var i = Var i

   mem :: (Ident,Ident) -> RHS -> [RR]
   mem (old,new) r = case r of
     LL.MemOp (LL.Store _ (TV t v) p) -> [RR new (CT $ Store t (val v) (val p) (var old))]
     LL.Call s ax                     -> [RR new (CT $ Proj Mem $ CT $ Call (val s) (map tval ax) (var old))]
     _ -> error ("Bad mem instruction:"++ show r)

   --rhs :: Ident -> RHS -> ST s [RR]
   rhs x r = case r of
     LL.MemOp (LL.Alloca t sz _al) -> do { fv <- fresh
                                         ; (old,new) <- newm
                                         ; return [ RR fv  (CT $ Alloc t (val sz) (var old))
                                                  , RR new (CT $ Proj Mem (var fv))
                                                  , RR x   (CT $ Proj Val (var fv)) ]
                                         }
     LL.MemOp (LL.Load _ (TV t v)) -> do { old <- curm
                                         ; return [RR x (CT $ Load t (val v) (var old))]
                                         }
     LL.Expr e     -> return [ RR x (expr e) ]
     LL.Phi {}     -> error "phi in rhs node"
     LL.Call s ax  | s == LL.Var (Ident "@llvm.objectsize.i32") -> return [RR x $ CT $ Call (val s) (map tval ax) (Var (Ident "$1"))]
                   | s == LL.Var (Ident "@llvm.objectsize.i64") -> return [RR x $ CT $ Call (val s) (map tval ax) (Var (Ident "$1"))]
                   | otherwise ->  do { fv <- fresh
                                      ; (old,new) <- newm
                                      ; let ax' = map tval ax
                                      ; return [ RR fv  (CT $ Call (val s) ax' (var old))
                                               , RR new (CT $ Proj Mem (var fv))
                                               , RR x   (CT $ Proj Val (var fv)) ]
                                      }
     _ -> fail ("Bad rhs instruction:"++ show r)

   tval (TV _ v)        = val v
   val (LL.Var v)       = var v
   val (LL.Const a)     = CT $ Const a
   val (LL.ConstExpr e) = expr e

   expr :: LL.Expr -> Term
   expr (LL.GetElemPtr (TV ty p) ndxs) = CT $ GetElemPtr ty (val p) (map tval ndxs)
   expr (LL.BinOp o s ty v1 v2)        = CT $ BinOp o s ty (val v1) (val v2)
   expr (LL.Conv o (TV ty v) ty')      = CT $ Conv o ty (val v) ty'
   expr (LL.Select c x y)              = CT $ Select (tval c) (tval x) (tval y)
   expr (LL.Extract (TV t v) xs)       = CT $ Extract t (val v) xs

   cont :: ControlInst -> Control
   cont ci = case ci of
     Unreachable            -> Ret $ CT $ Const Undef
     Return (Just (TV _ v)) -> Ret $ val v
     Return Nothing         -> Ret $ CT $ Const Undef
     Br l                   -> Seq $ trans l
     CBr v l1 l2            -> MBr (val v) (I 1) (trans l2) [(CT $ Const $ Int 1, trans l1)]
     Switch (TV ty v) l ls  -> let f (TV _ x,l') = (val x, trans l')
                               in MBr (val v) ty (trans l) (map f ls)
