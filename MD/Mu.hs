{-# LANGUAGE PatternGuards, TupleSections #-}
{-|
  Description : Generate mu-rules.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module generates mu-nodes for variables modified within a loop, and
  eta nodes for accesses to those variables outside the loop.
-}
module MD.Mu ( mkMU ) where
import Prelude hiding (mapM)
import Data.List
import Data.STRef
import Data.Traversable (mapM)
import qualified Data.Map as M
import Control.Monad hiding (mapM)
import Control.Monad.ST

import MD.Syntax.GDSA

--import Debug.Trace

mkMU :: [GBlock] -> [GBlock]
mkMU blocks = transEta $ muu M.empty [] blocks

-------------------------------------------------------------------------------
-- compute mu nodes for block headers

muu :: Ctx -> [GBlock] -> [GBlock] -> (Ctx, [GBlock])
muu ctx l []     = (ctx,l)
muu ctx l (b:bs) | Just (e,ls) <- loopHeader b = let b' = b { rules = rr e ++ rules b } in
                                                 let c' = newCtx b' ls in
                                                 muu c' (b':l) bs
                 | otherwise                   = muu ctx (b:l) bs
 where
   rr e = map (mkmu e) (phis b)
   mkmu entry (x,ty,~[(l1,t1),(_,t2)]) =
       let z = if l1 == entry then t1 else t2 in
       let n = if l1 == entry then t2 else t1 in
       RR x $ CT $ Mu ty z n

   newCtx b' ns = let get = getb (l++b':bs) in
                  let xs = concatMap (vars . get) ns in
                  foldl (\m (x,n) -> M.insert x (n,ns) m) ctx xs

   vars :: GBlock -> [(Ident,Label)]
   vars blk = let lbl = label blk in
              let xs = map (\rl -> (rrIdent rl,lbl)) (rules blk) in
              let ys = map (\(x,_,_) -> (x,lbl)) (phis blk) in
              xs ++ ys

getb :: [GBlock] -> Label -> GBlock
getb bs l = case find (\b -> label b == l) bs of
              Nothing -> error "getb: "
              Just b  -> b

-------------------------------------------------------------------------------
-- insert placeholders for eta-nodes

type Ctx = M.Map Ident (Label,[Label])

transEta :: (Ctx,[GBlock]) -> [GBlock]
transEta (ctx,bs) =
    runST $
    do { memo <- newSTRef M.empty
       ; bs' <- mapM (eta memo bs ctx) bs
       ; return bs'
       }

eta :: Memo a -> [GBlock] -> Ctx -> GBlock -> ST a GBlock
eta memo bs ctx b =
    do { ref <- newSTRef []
       ; rr <- mapM (fixRule ref) (rules b)
       ; ps <- mapM (fixPhi ref)  (phis b)
       ; cn <- fixControl ref (control b)
       ; ex <- liftM nub (readSTRef ref)
       ; er <- mapM (makeEta memo bs (label b)) ex
       ; return b { phis    = ps
                  , etas    = ex
                  , rules   = er ++ rr
                  , control = cn
                  }
       }
 where
   me = label b
   fresh v = Ident ('E': show v ++"."++ show me)

   fixRule r (RR i t)   = liftM (RR i) (fixTerm r t)
   fixPhi r (x,ty,arms) = do arms' <- mapM (fixArm r) arms
                             return (x,ty,arms')
   fixArm r (l,t)       = do t' <- fixTerm r t
                             return (l,t')
   fixControl r (Ret t)         = liftM Ret (fixTerm r t)
   fixControl _ (Seq l)         = return (Seq l)
   fixControl r (MBr t ty l ls) = do t' <- fixTerm r t
                                     ls' <- mapM (fixBranch r) ls
                                     return (MBr t' ty l ls')
   fixBranch r (t,l) = do t' <- fixTerm r t
                          return (t',l)

   fixTerm _ (CT (Phi {})) = fail "Mu.eta: phi found"
   fixTerm r (CT ct) = liftM CT (mapM (fixTerm r) ct)
   fixTerm r (Var i) = case M.lookup i ctx of
                       Nothing -> return $ Var i
                       Just (l,ls) | me `elem` ls -> return $ Var i
                                   | otherwise    ->
                                       do let new = fresh i
                                          modifySTRef r ((new,i,l,ls):)
                                          return (Var new)

-------------------------------------------------------------------------------

-- memoize condition for var 'Ident' from block 'Label'
type Memo a = STRef a (M.Map (Ident,Label) Term)

makeEta :: Memo a -> [GBlock] -> Label -> (Ident,Ident,Label,[Label]) -> ST a RR
makeEta memo bs froml (new,old,_,ls) =
    do { c <- findC memo bs ls old froml froml
       ; return $ RR new $ CT $ Eta c (Var old)
       }

findC :: Memo a -> [GBlock] -> [Label] -> Ident -> Label -> Label -> ST a Term
findC memo bs ls var to l =
    do { m <- readSTRef memo
       ; case M.lookup (var,l) m of
           Just t  -> return t
           Nothing -> do t <- findC' memo bs ls var to l
                         writeSTRef memo (M.insert (var,l) t m)
                         return t
       }

findC' :: Memo a -> [GBlock] -> [Label] -> Ident -> Label -> Label -> ST a Term
findC' memo bs ls var to l
    | l `notElem` ls = findC memo bs ls var l (pree blk)
    | otherwise      = return $ cond to blk
 where
   blk     = getb l
   isSeq   = case control blk of { Seq _ -> True ; _ -> False }
   getb bl = case find (\b -> label b == bl) bs of
               Nothing -> error "searchC:getb"
               Just x  -> x
   pree b | Just l     <- select dirs  = l
          | Just (e,_) <- loopHeader b = e
          | otherwise                  = hd (cfgpre b)
   hd [] = error "head infindC'"
   hd (x:_) = x

   dirs = concatMap (\(_,_,arms) -> arms) (phis blk)
   select []         = Nothing
   select ((l,t):ls) | var `elem` fvs t = Just l
                     | otherwise        = select ls

-- duplicate in MD.Phi

cond :: Label -> GBlock -> Term
cond l b = foldl1 land (getCond l b)
 where
   land x y = CT $ BinOp (Bop And) [] (I 1) x y

getCond :: Label -> GBlock -> [Term]
getCond tol fromb =
  case control fromb of
    Ret _          -> error "return is in from block"
    Seq _          -> []
    MBr t ty dl ts | dl == tol -> map (ne ty t . fst) ts
                   | otherwise ->
                       case find (\x -> tol == snd x) ts of
                         Nothing     -> error "no label in pre'"
                         Just (t',_) -> [eq ty t t']

eq,ne :: Type -> Term -> Term -> Term
eq ty a b = CT $ BinOp (Cmp MD.Syntax.GDSA.EQ) [] ty a b
ne ty a b = CT $ BinOp (Cmp MD.Syntax.GDSA.NE) [] ty a b
