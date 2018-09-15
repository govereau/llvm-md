{-# OPTIONS -fno-warn-orphans #-}
{-# LANGUAGE PatternGuards #-}
{-|
  Description : Rewrite/Normalization Rules for graphs.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module contains the rewriting rules for alue graphs.
-}
module MD.Rules
 ( TraceCallback, traceRules, applyRules )
where
import Prelude hiding (EQ)
import Data.Bits
import Data.List
import MD.Syntax.GDSA
import MD.Sharing
import MD.Aliasing
import System.Environment
import System.IO.Unsafe

-------------------------------------------------------------------------------
-- trace rules: apply one at a time

type TraceCallback = Int -> Value -> Value -> ValueGraph -> IO ()

traceRules :: TraceCallback -> ValueGraph -> IO ValueGraph
traceRules f vg =
    case applyOneRule vg of
      Nothing -> case partGraph vg of
                   Just vg' -> putStrLn "PARTITION" >>
                               traceRules f vg'
                   Nothing  -> return vg
      Just ((u,v,v'),vg0) ->
          do { let vg' = gMin vg0
             ; f u v v' vg'
             ; traceRules f vg'
             }

applyOneRule :: ValueGraph -> Maybe ((Int,Value,Value),ValueGraph)
applyOneRule valgr = trans valgr (uniqueKeys valgr)
 where
   trans _  []     = Nothing
   trans vg (u:us) =
       let v = fetchVal vg u in
       case tryRules vg u v of
         (NoChange,_)  -> trans vg us
         (Ref u', vg') -> Just ((u,v,fetchVal vg' u'), vg')
         (New v',vg')  -> Just ((u,v,v'), vg')

tryRules :: MRule
tryRules vg u val = f val myrules
 where
   f _ []     = (NoChange,vg)
   f v (r:rs) = let res = r vg u v in
                case fst res of
                  NoChange -> f v rs
                  _        -> res

-------------------------------------------------------------------------------
-- apply rules: as many as we can at once

applyRules :: ValueGraph -> ValueGraph
applyRules valgr = trans valgr (uniqueKeys valgr)
 where
   trans vg []     = if changed vg
                     then applyRules (gMin vg)
                     else case partGraph vg of
                            Just vg' -> applyRules vg'
                            Nothing  -> vg
   trans vg (u:us) =
       let v = fetchVal vg u in
       let vg' = tr vg u v myrules in
       if countReturns vg' == 1 then vg'  -- early termination.
       else trans vg' us

   tr vg _ _ []     = vg
   tr vg u v (r:rs) = let (res,vg') = r vg u v in
                      case res of
                        NoChange -> tr vg' u v  rs
                        New v'   -> tr vg' u v' rs
                        Ref _    -> vg'

-------------------------------------------------------------------------------
-- rule setup

data Result = NoChange | Ref Int | New Value

type Rule  = ValueGraph -> Value -> Result
type MRule = ValueGraph -> Int -> Value -> (Result,ValueGraph)
type ARule = (String, MRule)

simpleRule :: String -> Rule -> ARule
simpleRule s f = (s, rule)
 where
   rule vg u v = let res = f vg v in
                 case res of
                   NoChange           -> (NoChange,vg)
                   Ref u'             -> (Ref u', replaceValue u u' vg)
                   New v' | v' /= v   -> (New v', alterValue u v' vg)
                          | otherwise -> (NoChange, vg)

normalRule :: String -> MRule -> ARule
normalRule s r = (s,r)

-- rules are applied in this order

allrules :: [ARule]
allrules = [ simpleRule "cf" cf
           , simpleRule "cff64" cff64
           , simpleRule "ggep" ggep
      --     , normalRule "ic" ic
           , normalRule "ldphi" ldphi
           , simpleRule "phiTrim" phiTrim
           , simpleRule "phi" phi
           , simpleRule "phiMerge" phiMerge
--           , simpleRule "ldcall" ldcall
           , simpleRule "ldst" ldst
           , simpleRule "callmem" callmem
    --       , normalRule "stst" stst
           , normalRule "etaOp" etaOp
           , normalRule "etaMu" etaMu
           , simpleRule "retst" retst
           , normalRule "retphi" retphi
           ]

usedrules :: [ARule]
usedrules | null flags = allrules
          | otherwise  = filter (\(n,_) -> '-':n `elem` flags) allrules
 where
   args  = unsafePerformIO getArgs
   flags = filter (\s -> head s == '-') args

myrules :: [MRule]
myrules = map snd usedrules

-------------------------------------------------------------------------------
-- rule implementations

etaOp :: MRule
etaOp vg0 u (CV (Eta c v))
    | CV (BinOp op s ty x y) <- fetchVal vg0 v =
         let (vg1,u1) = insertValue (CV (Eta c x)) vg0 in
         let (vg2,u2) = insertValue (CV (Eta c y)) vg1 in
         let v'       = CV (BinOp op s ty u1 u2) in
         let vg3      = alterValue u v' vg2 in
         (New v', vg3)
    | CV (GetElemPtr ty p xs) <- fetchVal vg0 v =
         let (vg1,u1) = insertValue (CV (Eta c p)) vg0 in
         let v'       = CV (GetElemPtr ty u1 xs) in
         let vg2      = alterValue u v' vg1 in
         (New v', vg2)
    | CV (Load ty p m) <- fetchVal vg0 v =
         let (vg1,u1) = insertValue (CV (Eta c p)) vg0 in
         let (vg2,u2) = insertValue (CV (Eta c m)) vg1 in
         let v'       = CV (Load ty u1 u2) in
         let vg3      = alterValue u v' vg2 in
         (New v', vg3)
etaOp vg _ _ = (NoChange, vg)

etaMu :: MRule
etaMu vg u val@(CV (Eta c v)) =
    case (fetchVal vg c, fetchVal vg v) of
      (CV (Const (Int 0)), CV (Mu _ z _))          -> chgMu z
      (_                 , CV (Mu _ a b)) | a == b -> chgMu a
      (_                 , CV (Mu _ a b)) | b == v -> chgMu a
      (_                 , x)             | cnst x -> chg v
      _ -> (NoChange, vg)
 where
   chgMu x = (Ref x, replaceValue u x (replaceValue v x vg))
   chg   x = (Ref x, replaceValue u x vg)
   cnst (CV (Const _)) = True
   cnst (Param _)      = True
   cnst _              = False

etaMu vg _ _ = (NoChange,vg)

phiTrim :: Rule
phiTrim ns (CV (Phi ty al)) = New $ CV $ Phi ty $ sort $ nub $
                              filter possible $ map trim al
 where
   possible (PhiArm gs _) = not (any false gs)
   false u = case fetchVal ns u of
               CV (Const (Int 0)) -> True
               _                  -> False

   trim (PhiArm gs v) = PhiArm (sort $ nub $ filter notTrue gs) v
   notTrue u = case fetchVal ns u of
                  CV (Const (Int 1)) -> False
                  _                  -> True
phiTrim _ _ = NoChange

phiMerge :: Rule
phiMerge ns (CV (Phi ty arms)) = New $ CV $ Phi ty (sort $ nub $ concatMap (mergearm ns) arms)
phiMerge _ _ = NoChange

mergearm :: ValueGraph -> PhiArm Int -> [PhiArm Int]
mergearm ns (PhiArm gs v)
   | CV (Phi _ty arms) <- fetchVal ns v =
        map (\(PhiArm gs' v') -> PhiArm (sort $ nub (gs++gs')) v') arms
mergearm _ a = [a]

phi :: Rule
phi vg (CV (Phi _ [PhiArm _ v])) = Ref v
phi vg (CV (Phi _ (a:al))) =
    do { let v  = value a
       ; let vs = map value al
       ; if all (==v) vs then Ref v
         else case armvs (a:al) of
                Just x  -> Ref x
                Nothing -> NoChange
       }
 where
   armvs [] = Nothing
   armvs (PhiArm gs v:l) =
       let vs = map (fetchVal vg) gs in
       if all true vs then Just v else armvs l
   true (CV (Const (Int 1))) = True
   true _ = False

phi _ _ = NoChange

ldst :: Rule
ldst vg (CV (Load ty p m))
    | CV (Store ty' v p' _)  <- fetchVal vg m
    , ty == Pointer ty', p == p' = Ref v

--    | CV (Store (I n) v p' _)  <- fetchVal vg m   --- little-endian only
--    , findAlloc vg p == findAlloc vg p'
--    , CV (Const (Int i)) <- fetchVal vg v
--    , Pointer (I j) <- ty
--    , j < n                = New $ CV $ Const $ Int (i .&. (2^j - 1))

    | CV (Store _   _ p' m') <- fetchVal vg m
    , not (mayAlias vg p p') = New $ CV $ Load ty p m'

--    | CV (Proj Mem m') <- fetchVal vg m
--    , CV (Alloc _ _ m'') <- fetchVal vg m'
--    , CV (Proj Val pv) <- fetchVal vg p
--    , m' /= pv = New $ CV $ Load ty p m''
ldst _ _ = NoChange

{-
stst :: MRule
stst ns umin (CV (Store ty v p m))
    | Nothing <- findAlloc ns p
    , CV (Store ty' v' p' m') <- fetchVal ns m
    , Just _ <- findAlloc ns p' =
        swapm (CV . Store ty' v' p') m'
    | Nothing <- findAlloc ns p
    , CV (Proj Mem m') <- fetchVal ns m
    , CV (Alloc aty n m'') <- fetchVal ns m' =
        let u = maximum (umin:map getKey ns) in
        let s = Mapping (u+1) $ CV $ Store ty v p m'' in
        let a = Mapping (u+2) $ CV $ Alloc aty n (u+1) in
        let x = CV $ Proj Mem (u+2) in
        (x, [s,a])
 where
   swapm c m' = case newVal umin ns (CV (Store ty v p m')) of
                  Left key   -> (c key, [])
                  Right node -> (c (getKey node), [node])

stst _ _ val = (val, [])
-}

retst :: Rule
retst vg (CV (Returns (v,m)))
    | CV (Store _ _ p m') <- fetchVal vg m
    , Just (Local _) <- findPtr vg p = New $ CV (Returns (v,m'))
    | CV (Proj Mem m') <- fetchVal vg m
    , CV (Alloc _ _ m'') <- fetchVal vg m' = New $ CV (Returns (v, m''))
retst _ _ = NoChange

retphi :: MRule
retphi vg _ val@(CV (Returns (_,m)))
    | CV (Phi ST arms) <- fetchVal vg m =
        let m' = CV $ Phi ST (map (memarm vg) arms)
        in (NoChange, alterValue m m' vg)    -- but we changed something...
retphi vg _ _ = (NoChange,vg)

memarm :: ValueGraph -> PhiArm Int -> PhiArm Int
memarm ns (PhiArm gs v)
    | CV (Store _ _ p m) <- fetchVal ns v
    , Just _ <- findAlloc ns p = PhiArm gs m
    | CV (Proj Mem m) <- fetchVal ns v
    , CV (Alloc _ _ m') <- fetchVal ns m = PhiArm gs m'
memarm _ a = a

callmem :: Rule
callmem vg (CV (Call f al m))
    | (CV (Store _ _ p m')) <- fetchVal vg m
    , all (not . mayAlias vg p) al = New $ CV (Call f al m')

    | (CV (Proj Mem m')) <- fetchVal vg m
    , (CV (Alloc _ _ m3)) <- fetchVal vg m'
    , all (not . mayAlias vg m') al = New $ CV (Call f al m3)
callmem _ _ = NoChange

ldcall :: Rule
ldcall ns (CV (Load ty p m))
    | CV (Proj Mem m0) <- fetchVal ns m
    , CV (Call _f al m') <- fetchVal ns m0
    , all (\x -> not (mayAlias ns p x)) al = New $ CV (Load ty p m')
ldcall _ _ = NoChange

ldphi :: MRule
ldphi vg u (CV (Load lty p m))
    | CV (Phi _ty arms) <- fetchVal vg p =
        let (vg',xs) = newVals vg (map (\a -> CV (Load lty (value a) m)) arms) in
        let arms' = sort $ nub $ zipWith (\a x -> a { value = x }) arms xs in
        let v' = CV $ Phi lty arms' in
        (New v', alterValue u v' vg')
    | CV (Phi ST arms) <- fetchVal vg m
    , Pointer ty <- lty =
        let (vg',xs) = newVals vg (map (\a -> CV (Load lty p (value a))) arms) in
        let arms' = sort $ nub $ zipWith (\a x -> a { value = x }) arms xs in
        let v' = CV $ Phi ty arms' in
        (New v', alterValue u v' vg')
ldphi vg _ _ = (NoChange, vg)

ggep :: Rule
-- for sha1
ggep ns (CV (GetElemPtr _pty1 p1 [x,y]))
    | CV (Const (Int 0)) <- fetchVal ns x
    , CV (Const (Int 0)) <- fetchVal ns y
    = Ref p1

-- combining
ggep ns (CV (GetElemPtr _pty1 p1 xs1))
    | CV (GetElemPtr pty2 p2 xs2) <- fetchVal ns p1
    , (x:xs) <- xs1
    , CV (Const (Int 0)) <- fetchVal ns x
    = New $ CV (GetElemPtr pty2 p2 (xs2++xs))


ggep vg (CV (Conv Bitcast (Pointer _) p (Pointer _))) = Ref p
ggep _ _ = NoChange

-------------------------------------------------------------------------------
-- constant folding

instance Num Const where
    (+) (Int   a) (Int   b) = Int   (a+b)
    --(+) (Float a) (Float b) = Float (a+b)
    --(+) (Int   a) (Float b) = cvtToDbl a + Float b
    --(+) (Float a) (Int   b) = Float a + cvtToDbl b
    (+) _ _ = error "no plus"

    (-) (Int   a) (Int   b) = Int   (a-b)
    --(-) (Float a) (Float b) = Float (a-b)
    --(-) (Int   a) (Float b) = cvtToDbl a - Float b
    --(-) (Float a) (Int   b) = Float a - cvtToDbl b
    (-) _ _ = error "no minus"

    (*) (Int   a) (Int   b) = Int   (a*b)
    --(*) (Float a) (Float b) = Float (a*b)
    --(*) (Int   a) (Float b) = cvtToDbl a * Float b
    --(*) (Float a) (Int   b) = Float a * cvtToDbl b
    (*) _ _ = error "no times"

    abs         = error "Num.abs"
    signum      = error "Num.signum"
    fromInteger = error "Num.fromInteger"

instance Bits Const where
    (.&.) (Int a) (Int b) = Int (a .&. b)
    (.&.) _ _ = error "no and"
    (.|.) (Int a) (Int b) = Int (a .|. b)
    (.|.) _ _ = error "no or"
    xor   (Int a) (Int b) = Int (xor a b)
    xor   _ _ = error "no xor"

    complement = error "Bits"
    bitSize    = error "Bits"
    isSigned   = error "Bits"

cf :: Rule
cf _ (CV (BinOp (Cmp EQ) [] _ p1 p2)) | p1 == p2 = New $ CV (Const $ Int 1)
cf _ (CV (BinOp (Cmp NE) [] _ p1 p2)) | p1 == p2 = New $ CV (Const $ Int 0)

cf ns (CV (BinOp (Cmp EQ) [] (I 1) p1 p2))
    | CV (Const (Int 1)) <- fetchVal ns p1 = Ref p2
    | CV (Const (Int 1)) <- fetchVal ns p2 = Ref p1
cf ns (CV (BinOp (Cmp NE) [] (I 1) p1 p2))
    | CV (Const (Int 0)) <- fetchVal ns p1 = Ref p2
    | CV (Const (Int 0)) <- fetchVal ns p2 = Ref p1

cf ns (CV (BinOp (Bop And) [] (I _) p1 p2))
    | CV (Const (Int 0)) <- fetchVal ns p1 = New $ CV (Const $ Int 0)
    | CV (Const (Int 0)) <- fetchVal ns p2 = New $ CV (Const $ Int 0)
cf ns (CV (BinOp (Bop Or) [] (I _) p1 p2))
    | CV (Const (Int 0)) <- fetchVal ns p1 = Ref p2
    | CV (Const (Int 0)) <- fetchVal ns p2 = Ref p1

cf ns val@(CV (BinOp opr _ _ p1 p2)) =
    case (fetchVal ns p1, fetchVal ns p2) of
      (CV (Const c1), CV (Const c2)) ->
          case opr of
            Bop And  -> New $ CV (Const $ c1 .&. c2)
            Bop Or   -> New $ CV (Const $ c1 .|. c2)
            Bop Xor  -> New $ CV (Const $ xor c1 c2)
            Cmp EQ    | c1 == c2 -> New $ CV (Const $ Int 1)
            Cmp EQ    | c1 /= c2 -> New $ CV (Const $ Int 0)
            Cmp NE    | c1 == c2 -> New $ CV (Const $ Int 0)
            Cmp NE    | c1 /= c2 -> New $ CV (Const $ Int 1)
            FCmp Oeq  | c1 == c2 -> New $ CV (Const $ Int 1)
            FCmp Oeq  | c1 /= c2 -> New $ CV (Const $ Int 0)
            FCmp One  | c1 == c2 -> New $ CV (Const $ Int 0)
            FCmp One  | c1 /= c2 -> New $ CV (Const $ Int 1)
            Bop Add  -> New $ CV (Const $ c1+c2)
            Bop Mul  -> New $ CV (Const $ c1*c2)
            Bop Sub  -> New $ CV (Const $ c1-c2)
            --Bop FAdd -> New $ CV (Const $ c1+c2)
            --Bop FMul -> New $ CV (Const $ c1*c2)
            --Bop FSub -> New $ CV (Const $ c1-c2)
            _ -> NoChange
      _ -> NoChange
--cp _ val@(CV (Conv Bitcast _ty1 p _ty2)) = Ref p
cf ns val@(CV (Conv op (I n) p (I m))) =
    case fetchVal ns p of
      CV (Const (Int c)) ->
          case op of
            SExt | m >= n -> New $ CV (Const (Int c))
            ZExt | m >= n, c < 2^n -> New $ CV (Const (Int c))
            _    -> NoChange
      _ -> NoChange
cf _ _ = NoChange

cff64 :: Rule
cff64 ns val@(CV (BinOp opr [] F64 p1 p2)) =
    case (fetchVal ns p1, fetchVal ns p2) of
      (CV (Const (Float s1)), CV (Const (Float s2))) ->
          case opr of
            Bop FMul -> New $ CV $ Const $ Float $ f2s (s2f s1 * s2f s2)
            _        -> NoChange
      _ -> NoChange
 where
   s2f :: String -> Float
   f2s :: Float -> String
   s2f s = read s
   f2s f = show f

cff64 _ _ = NoChange

-------------------------------------------------------------------------------
-- instcombine rules

ic :: MRule
-- If a binary operator has a constant operand, it is moved to the right-
-- hand side. (constants include function parameters... -pg)

ic vg u (CV (BinOp opr s ty p1 p2))
    | isConst (fetchVal vg p1)
    , not (isConst (fetchVal vg p2)) =
        let swapped o = newV vg u (CV $ BinOp o s ty p2 p1) in
        case opr of
          Bop Add  -> swapped opr
          Bop FAdd -> swapped opr
          Bop Mul  -> swapped opr
          Bop FMul -> swapped opr
          Bop And  -> swapped opr
          Bop Or   -> swapped opr
          Bop Xor  -> swapped opr
          Cmp EQ   -> swapped opr
          Cmp NE   -> swapped opr
          Cmp UGT  -> swapped (Cmp ULT)
          Cmp UGE  -> swapped (Cmp ULE)
          Cmp ULT  -> swapped (Cmp UGT)
          Cmp ULE  -> swapped (Cmp UGE)
          Cmp SGT  -> swapped (Cmp SLT)
          Cmp SGE  -> swapped (Cmp SLE)
          Cmp SLT  -> swapped (Cmp SGT)
          Cmp SLE  -> swapped (Cmp SGE)
          _        -> (NoChange, vg)

 where
   isConst :: Value -> Bool
   isConst (CV (Const _)) = True
   isConst (Param _)      = True
   isConst _ = False

-- Compare instructions are converted from <, >, <=, or >= to = or != if
-- possible.
ic vg u (CV (BinOp (Cmp SGT) s (I _) p1 p2))
   | CV (Conv ZExt ty p3 _) <- fetchVal vg p1
   , CV (Const (Int 0)) <- fetchVal vg p2 =
         newC vg u (BinOp (Cmp NE) s ty p3) 0

ic vg u (CV (BinOp (Cmp op) s ty p1 p2))
    | CV (Const (Int n)) <- fetchVal vg p2 =
         case op of
           SGT -> newC vg u (BinOp (Cmp SGE) s ty p1) (n+1)
           SLT -> newC vg u (BinOp (Cmp SLE) s ty p1) (n-1)
           _ -> (NoChange, vg)

-- add X, X is represented as mul X, 2 => shl X, 1
ic vg u (CV (BinOp (Bop Add) _ ty p1 p2))
    | p1 == p2 =
        newC vg u (BinOp (Bop Shl) [] ty p1) 1
ic vg u (CV (BinOp (Bop Mul) _ ty p1 p2))
    | CV (Const (Int k)) <- fetchVal vg p2
    , Just p <- power 1 k =
        newC vg u (BinOp (Bop Shl) [] ty p1) p
 where
   power n i | n > 31    = Nothing
             | 2^n == i  = Just n
             | otherwise = power (n+1) i

ic vg u (CV (BinOp (Bop Add) s ty p1 p2))
    | (CV (Const (Int n))) <- fetchVal vg p2
    , n < 0 =
        newC vg u (BinOp (Bop Sub) s ty p1) (negate n)

ic vg _ _ = (NoChange,vg)


newV :: ValueGraph -> Int -> Value -> (Result, ValueGraph)
newV vg u v = (New v, alterValue u v vg)

newC :: ValueGraph -> Int -> (Int -> Common Int) -> Integer -> (Result,ValueGraph)
newC vg u c x = let cx = CV (Const (Int x)) in
                let (vg1,px) = insertValue cx vg in
                newV vg1 u (CV $ c px)

newVals :: ValueGraph -> [Value] -> (ValueGraph, [Int])
newVals valgr vs = (valgr', reverse rl)
 where
   (valgr', rl)  = foldl f (valgr,[]) vs
   f (vg,l) v = let (vg',u) = insertValue v vg in (vg', u:l)

--newVal :: Int -> ValueGraph -> Value -> Either Int (Mapping Int Value)
--newVal u ns v =
--    case findByValue ns v of
--      Nothing  -> Right $ Mapping (maximum (u:map getKey ns) + 1) v
--      Just key -> Left key
