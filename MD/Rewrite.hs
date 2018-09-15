{-# LANGUAGE PatternGuards #-}
{-|
  Description : Symbolic evaluation.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module implements bottom-up symbolic evaluation of GDSA programs.
-}
module MD.Rewrite
  ( simplify, inline
  , binop, eq, ne, inv
  )
where
import Data.List
import Data.Char
import Data.Maybe
import Data.Bits
import MD.Syntax.GDSA
import MD.Aliasing

-- | Compute symbolic value of a term given a set of GDSA rewrite rules and
-- aliasing information.

simplify :: AliasRules -> [RR] -> Term -> Term
simplify arules rr = subst
 where
   subst :: Term -> Term
   subst (Atom (Var i))        = fetch i
   subst (Atom a)              = Atom a
   subst (Proj i x)            = Proj i (subst x)
   subst (GetElemPtr ty t l)   = GetElemPtr ty (subst t) (map subst l)
   subst (BinOp o s ty v1 v2)  = binop o s ty (subst v1) (subst v2)
   subst (Conv o vty v ty)     = conv o vty (subst v) ty
   subst (Select a b c)        = Select (subst a) (subst b) (subst c)
   subst (Alloc ty n t)        = Alloc ty n (subst t)
   subst (Load ty t p)         = load arules ty (subst t) (subst p)
   subst (Store ty x y z)      = Store ty (subst x) (subst y) (subst z)

   subst (Phi t arms) = phi t (map sarm arms)

   subst (Mu t b x)       = subst $ muToOmega fetch t b x
   subst (Omega x t c ss) =
       case omega x t (subst c) (map ssq ss) of
         t'@(Phi {}) -> subst t'
         Omega _ t' c' ss' ->
             let f (v,i) = RR (P (Ident v)) (Atom (Var (Ident ('!':show i)))) in
             let vs = map (\(SeqRules v _ _) -> v) ss' in
             let rr' = map f $ zip vs [(1::Int)..] in
             let rr'' = rr' ++ rr in
             Omega (Ident []) t' (simplify arules rr'' c') (map (ssq' rr'') ss')
         t' -> t'
   subst (Call f ax i)  = Call (subst f) (map subst ax) (subst i)

   sarm (PhiArm cs t) =
       let cs' = map subst cs in
       let rr' = condRules cs' in
       PhiArm cs' (simplify arules (rr'++rr) t)

   ssq' rr' (SeqRules _ a b) = let f = simplify arules rr' in
                               SeqRules [] (f a)     (f b)
   ssq      (SeqRules n a b) = SeqRules n  (subst a) (subst b)

   tbl     = (Ident "$0", Atom Undef) : map (\(RR i t) -> (i,t)) rr
   fetch i = case lookup i tbl of
               Nothing -> Atom (Var i)
               Just t  -> subst t

-------------------------------------------------------------------------------
-- Phi

phi :: Type -> [PhiArm] -> Term
phi ty arms
    | allSame   = value (head arms')
    | otherwise = case find isTrue arms' of
                    Just (PhiArm _ t) -> t
                    Nothing           -> Phi ty sorted
 where
   isTrue (PhiArm cs _)   = all (==Atom (Int 1)) cs
   notFalse (PhiArm cs _) = all (/=Atom (Int 0)) cs
   allSame = let ~(x:xs) = map value arms' in all (==x) xs

   sorted  = nub $ sort $ filter notFalse $ map sort' arms'
   sort' a = PhiArm (nub $ sort $ guard a) (value a)

   arms' = concatMap (flat []) arms
   flat :: [Term] -> PhiArm -> [PhiArm]
   flat cs (PhiArm l t) = case t of
                            Phi _ ax -> concatMap (flat (cs++l)) ax
                            _        -> [PhiArm (cs++l) t]

-- Convert a set of guards into rules that can be used to simplify an arm

condRules :: [Term] -> [RR]
condRules ts = mapMaybe ruleFor ts
 where
   ruleFor (Atom (Var v)) = Just $ RR v (Atom (Int 1))
   ruleFor (BinOp (Cmp MD.Syntax.GDSA.EQ) [] _ x y) = var x y
   ruleFor _ = Nothing

   var (Atom (Var v)) t = Just (RR v t)
   var t (Atom (Var v)) = Just (RR v t)
   var _ _ = Nothing

-------------------------------------------------------------------------------
-- mu and omega

omega :: Ident -> Type -> Term -> [Sequence] -> Term
omega (Ident x) ty c (SeqRules x' t1 t2 : _)
    | x == x', isConst t1, isConst t2 =
        let fv  = fivs c in
        let rr  = map (\v -> RR (P v) (Atom $ Var $ Z v)) fv in
        let c'  = simplify allAlias rr c in
        Phi ty [ PhiArm [c'] t1, PhiArm [inv c'] t2 ]
omega x ty c l = Omega x ty c l

isConst :: Term -> Bool
isConst (Atom (Var _)) = False
isConst (Atom _) = True
isConst _ = False

muToOmega :: (Ident -> Term) -> Type -> Ident -> Ident -> Term
muToOmega fetch ty b var =
    Omega { variable  = var
          , vartype   = ty
          , condition = cond_term
          , sequences = deps [] $ nub (var : fivs cond_term)
          }
 where
   cond_term = fetch (N b)

   deps :: [Ident] -> [Ident] -> [Sequence]
   deps _ []     = []
   deps l (v:vs) =
       let vz = fetch (Z v) in
       let vn = fetch (N v) in
       let x  = SeqRules (show v) vz vn in
       let fv = new (v:l) (fivs vz `union` fivs vn `union` vs) in
       x : deps (v:l) fv

   new l l' = filter (\x -> notElem x l) l'

-------------------------------------------------------------------------------

load :: AliasRules -> Type -> Term -> Term -> Term
load ars ty p (Store _ v p' m)
    | p == p'                 = v
    | not (mayAlias ars p p') = load ars ty p m

load ars (Pointer t) p (Phi _ arms) =
    let f (PhiArm c x) = PhiArm c (load ars (Pointer t) p x) in
    let arms' = map f arms in
    simplify ars [] (Phi t arms')
load ars ty p (Call _f args m) --What about the returned pointer???
     | checkArgs args p ars = load ars ty p m
load _ _ _ (Atom undef) = Atom undef
load _ ty p m = Load ty p m

checkArgs :: [Term] -> Term -> AliasRules -> Bool
checkArgs [] _ _ = True
checkArgs (i:l) p ars = case i of
  GetElemPtr t a ixs  -> not (mayAlias ars p (GetElemPtr t a ixs)) && checkArgs l p ars
  Conv InttoPtr _ _ _ -> False --What about bitcast?
  _                   -> True


conv :: ConvOp -> Type -> Term -> Type -> Term
conv SExt (I n) (Atom (Int i)) (I m) | m >= n = Atom (Int i)
conv ZExt (I n) (Atom (Int i)) (I m) | m >= n, i < 2^n = Atom (Int i)
conv op ty t ty' = Conv op ty t ty'

binop :: Opr -> String -> Type -> Term -> Term -> Term
--instcombine
-- binop (Bop Add) s1 s2 a1 a2 | a1 == a2 = BinOp (Bop Shl) s1 s2 a1 (Atom (Int 1))
-- binop (Cmp SGE) s1 s2 a1 (Atom (Int i)) = BinOp (Cmp SGT) s1 s2 a1 (Atom (Int (i - 1)))
-- binop (Cmp SLE) s1 s2 a1 (Atom (Int i)) = BinOp (Cmp SLT) s1 s2 a1 (Atom (Int (i + 1)))
--binop (Cmp MD.Syntax.GDSA.EQ) s1 (I 1) (BinOp (Cmp MD.Syntax.GDSA.EQ) s2 (I 32) a (Atom (Int 0))) (Atom (Int 0)) = BinOp (Cmp MD.Syntax.GDSA.EQ) s1 (I 32) a (Atom (Int 0)) 
-- binop (Cmp MD.Syntax.GDSA.EQ) s1 (I 1) (BinOp (Cmp MD.Syntax.GDSA.EQ) s2 (Pointer (I 8)) a (Atom Null)) (Atom (Int 0)) = BinOp (Cmp MD.Syntax.GDSA.EQ) s1 (Pointer (I 8)) a (Atom Null) 
--end

binop (Cmp MD.Syntax.GDSA.EQ) _ (I 1) (BinOp (Cmp MD.Syntax.GDSA.EQ) s' t' a b) (Atom (Int 0)) = BinOp (Cmp MD.Syntax.GDSA.NE) s' t' a b

binop (Bop op) _ _ (Atom (Int i1)) (Atom (Int i2)) = Atom (Int x)
      where x = case op of
                Add -> i1 + i2
                Sub -> i1 - i2
                Mul -> i1 * i2
                SDiv -> div i1 i2
                SRem -> mod i1 i2
                Or   -> i1 .|. i2
                And  -> i1 .&. i2
                _ -> error ("NIY:"++ show op)

binop (Bop op) _ _ (Atom (Float i1)) (Atom (Float i2)) = Atom (Float x)
      where x = case op of
                FAdd -> i1 + i2
                FSub -> i1 - i2
                FMul -> i1 * i2
                FDiv -> i1 / i2
                _ -> error ("NIY: "++ show op)

binop (Bop MD.Syntax.GDSA.And) _ _ (Atom (Int 0)) _ = Atom (Int 0)
binop (Bop MD.Syntax.GDSA.And) _ _ _ (Atom (Int 0)) = Atom (Int 0)

binop (Bop MD.Syntax.GDSA.Or) _ _ (Atom (Int 0)) t = t
binop (Bop MD.Syntax.GDSA.Or) _ _ t (Atom (Int 0)) = t

binop (Bop MD.Syntax.GDSA.And) _ _ t1 t2 | t1 == t2 = t1
binop (Bop MD.Syntax.GDSA.Or)  _ _ t1 t2 | t1 == t2 = t1

binop (Cmp MD.Syntax.GDSA.EQ) _ _ t1 t2 | t1 == t2 = Atom (Int 1)
binop (Cmp MD.Syntax.GDSA.NE) _ _ t1 t2 | t1 == t2 = Atom (Int 0)

-- this kind of code is generated by Convert.hs, and we can simplify it here
binop (Cmp MD.Syntax.GDSA.EQ) _ _ b@(BinOp (Cmp _) _ _ _ _) (Atom (Int 1)) = b
binop (Cmp MD.Syntax.GDSA.EQ) _ _ (BinOp (Cmp MD.Syntax.GDSA.NE) s ty t1 t2) (Atom (Int 0)) =
    BinOp (Cmp MD.Syntax.GDSA.EQ) s ty t1 t2

binop (Cmp op) _ _ (Atom (Int i1)) (Atom (Int i2)) = Atom (Int $ toInteger $ fromEnum x)
      where x = case op of
                MD.Syntax.GDSA.EQ  -> i1 == i2
                MD.Syntax.GDSA.NE  -> i1 /= i2
                MD.Syntax.GDSA.SGT -> i1 >  i2
                MD.Syntax.GDSA.SGE -> i1 >= i2
                MD.Syntax.GDSA.SLT -> i1 <  i2
                MD.Syntax.GDSA.SLE -> i1 <= i2
                _ -> error ("NIY : "++ show op)

binop op s ty t1 t2 = BinOp op s ty t1 t2

eq,ne :: Type -> Term -> Term -> Term
eq = binop' (Cmp MD.Syntax.GDSA.EQ) []
ne = binop' (Cmp MD.Syntax.GDSA.NE) []

inv :: Term -> Term
inv t = eq (I 1) t (Atom (Int 0))

binop' :: Opr -> String -> Type -> Term -> Term -> Term
binop' op s ty x y = case binop op s ty x y of
  BinOp (Cmp MD.Syntax.GDSA.EQ) _ _ b (Atom (Int 1)) -> b
  BinOp (Cmp MD.Syntax.GDSA.EQ) _ _ (Atom (Int 1)) b -> b
  BinOp (Cmp MD.Syntax.GDSA.NE) _ _ b (Atom (Int 0)) -> b
  BinOp (Cmp MD.Syntax.GDSA.NE) _ _ (Atom (Int 0)) b -> b
  BinOp (Cmp MD.Syntax.GDSA.NE) _ t b (Atom (Int 1)) -> eq t b (Atom (Int 0))
  BinOp (Cmp MD.Syntax.GDSA.NE) _ t (Atom (Int 1)) b -> eq t b (Atom (Int 0))
  bop -> bop

-------------------------------------------------------------------------------
-- | Basic inlining support.

inline :: [(String,[Ident],Term,Term)] -> Term -> Term
inline fns = inl
 where
   inl (Atom a)              = Atom a
   inl (Proj i x)            = Proj i (inl x)
   inl (GetElemPtr ty t l)   = GetElemPtr ty (inl t) (map inl l)
   inl (BinOp o s ty v1 v2)  = BinOp o s ty (inl v1) (inl v2)
   inl (Conv o vty v ty)     = conv o vty (inl v) ty
   inl (Select a b c)        = Select (inl a) (inl b) (inl c)
   inl (Alloc ty n t)        = Alloc ty n (inl t)
   inl (Load ty t p)         = Load ty (inl t) (inl p)
   inl (Store ty a b c)      = Store ty (inl a) (inl b) (inl c)
   inl (Phi ty arms)         = Phi ty (map arm arms)
   inl (Mu t b x)            = Mu t b x
   inl (Omega i ty t ss)     = Omega i ty (inl t) (map inls ss)
   inl (Call s ax i)         = call s ax i
   inls (SeqRules n a b)     = SeqRules n (inl a) (inl b)

   arm (PhiArm cs t) = PhiArm (map inl cs) (inl t)
   call s ax i = case find (\(s',_,_,_) -> s' == show s) fns of
                   Nothing        -> Call s (map inl ax) (inl i)
                   Just (_,l,b,_) -> let vs = [ Ident [x] | x <- map chr [1..]] in
                                     let ts = [ Atom (Var v) | v <- vs] in
                                     let l1 = mkrr ts l in
                                     let l2 = mkrr ax vs
                                     in inl $ simplify allAlias l2 $ simplify allAlias l1 b

mkrr :: [Term] -> [Ident] -> [RR]
mkrr ts is = map f $ zip ts is
 where f (t,i) = RR i t
