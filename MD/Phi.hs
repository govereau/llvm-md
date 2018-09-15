{-# LANGUAGE TupleSections, PatternGuards #-}
{-|
  Description : Generate guarded phi-nodes.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module computes the guards for phi-nodes that do not appear in loop
  headers.
-}
module MD.Phi
  ( computePhi, eq, ne )
where
import Control.Monad hiding (guard)
import Control.Monad.ST
import Data.STRef
import qualified Data.Map as M
import Data.List
import Data.Maybe
import MD.Syntax.GDSA

-------------------------------------------------------------------------------
-- | Compute guarded phi nodes.

computePhi :: [GBlock] -> [GBlock]
computePhi bs = map (\b -> {-transE info $-} trans info b) bs
 where
   bmap = M.fromList [ (label b, b) | b <- bs ]
   info = runST $ do { memo <- newSTRef M.empty
                     ; forM_ bs $ \b ->
                       do { when (hasPhi b) $
                            follow memo bmap b (idom b) >> return ()
                          --; forM_ (etas b) $ \(_,_,l) ->
                            --follow memo bmap b l >> return ()
                          }
                     ; readSTRef memo
                     }

hasPhi :: GBlock -> Bool
hasPhi = not . null . phis

type Data = [(Int, [[Term]])]
type Memo = M.Map (Int,Int) Data

follow :: STRef a Memo -> M.Map Label GBlock -> GBlock -> Label -> ST a Data
follow memo bs fromb tol = followM fromb (getb tol)
 where
   followM f t | f == t = return []
   followM f t =
       do { mx <- get f t
          ; case mx of
              Just x  -> return x
              Nothing -> follow' f t >>= put f t
          }
   put f t ts = modifySTRef memo (M.insert (label f, label t) ts) >>
                return ts
   get f t = do { m <- readSTRef memo
                ; return $ M.lookup (label f, label t) m
                }

   follow' f t | length (pree f) > 1, idom f /= label t = followM (getb $ idom f) t
   follow' f t =
       do { let preds = map getb (pree f)
          ; let tss = map (getCond f) preds
          ; css <- mapM (\x -> followM x t) preds
          ; return $ zipWith3 combine (pree f) tss css
          }

   combine :: Int -> [Term] -> Data -> (Int, [[Term]])
   combine l ts [] = (l, [ts])
   combine l ts cs = (l, map (ts++) $ concatMap snd cs)

   pree b | Just (e,_) <- loopHeader b = [e]
          | otherwise                  = cfgpre b

   getb n = case M.lookup n bs of
              Nothing -> error ("getb:"++ show n)
              Just x  -> x

-- generate condition for a single edge

getCond :: GBlock -> GBlock -> [Term]
getCond tob fromb =
  case control fromb of
    Ret _          -> error "return is in from block"
    Seq _          -> []
    MBr t ty dl ts | dl == label tob -> map (ne ty t . fst) ts
                   | otherwise ->
                       case find (\x -> label tob == snd x) ts of
                         Nothing     -> error "no label in pre'"
                         Just (t',_) -> [eq ty t t']

eq,ne :: Type -> Term -> Term -> Term
eq ty a b = CT $ BinOp (Cmp MD.Syntax.GDSA.EQ) [] ty a b
ne ty a b = CT $ BinOp (Cmp MD.Syntax.GDSA.NE) [] ty a b

-------------------------------------------------------------------------------
-- stage 2: translate phis

trans :: Memo -> GBlock -> GBlock
trans info blk | null (phis blk)         = blk
               | isJust (loopHeader blk) = blk
               | otherwise               = convert blk
 where
   convert b = b { rules = map (cvt $ getData b) (phis b) ++ rules b }
   cvt _ (i,_,[(_,t)]) = RR i t
   cvt d (i,ty,ts)     = RR i $ CT $ Phi ty $ concatMap (arm d) ts

   getData b = case M.lookup (label b, idom b) info of
                 Nothing -> error ("phi trans no data:"++ show b)
                 Just d  -> d

   arm :: Data -> (Int,Term) -> [PhiArm Term]
   arm dat (lbl,trm) =
       case lookup lbl dat of
         Nothing  -> error "phi trans edge data"
         Just ccs -> map (\cs -> PhiArm cs trm) ccs

-------------------------------------------------------------------------------
-- stage 3: translate etas

{-
transE :: Memo -> GBlock -> GBlock
transE info blk = blk { rules = map cvt (etas blk) ++ rules blk }
 where
   cvt (new,old,l) = RR new $ CT $ Eta (getC l) (Var old)

   -- this isn't great for syntactic equality...
   getC l = case M.lookup (label blk, l) info of
              Nothing -> error ("eta trans no data:"++ show blk)
              Just ls -> disj (concatMap snd ls)

   disj [] = CT (Const $ Int 0)
   disj xs = foldl1 lor (map conj xs)
   conj [] = CT (Const $ Int 1)
   conj xs = foldl1 land xs
   lor  x y = CT (BinOp (Bop Or)  "" (I 1) x y)
   land x y = CT (BinOp (Bop And) "" (I 1) x y)
-}
