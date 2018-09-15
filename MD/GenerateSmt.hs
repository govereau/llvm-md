{-# OPTIONS -w #-} -- John doesn't read warnings...

{-|
  Description : Translation of symbolic values into an SMT script.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Jean-Baptiste Tristan <tristan@seas.harvard.edu>

  This module implements generation of SMT-LIB scripts.
-}
module MD.GenerateSmt
  ( script )
where 
import Data.Set
import MD.Syntax.GDSA
import MD.Sharing

{-Ignore the returned memories for now-}
script :: ValueGraph -> Int -> Int -> String
script vg' r1 r2 = 
    let vg = preprocess vg' in
    let (CV (Returns (vi1,mi1))) = fetchVal vg r1
        (CV (Returns (vi2,mi2))) = fetchVal vg r2 in
    let v1 = fetchVal vg vi1
        v2 = fetchVal vg vi2 
        m1 = fetchVal vg mi1
        m2 = fetchVal vg mi2 in
    (show vg)++"\n\n\n"++
        sConcat[
            phiTheory "phi" int, "\n",
            phiTheory "phimem" memType,"\n",
            listTheory,"\n",
            gepTheory,"\n\n",
            (generateConstants (getParams vg)),"\n",
            (gDecl mem [] memType),"\n",
            "(assert (or","\n",
            "(not (=","\n",(translateValue vg wordType v1),"\n",
                (translateValue vg wordType v2),"\n",
                "))","\n",
            "(not (=","\n",(translateValue vg ST m1),"\n",
                (translateValue vg ST m2),"\n",
                "))","\n",
            "))","\n",
            "(check-sat)","\n","(model)","\n"]

{-***Helper Functions***-}

wordsize :: Int
wordsize = 32
wordsizeg :: Integer
wordsizeg = (fromIntegral wordsize)
longsize :: Int
longsize = 2*wordsize
longsizeg :: Integer
longsizeg = (fromIntegral longsize)

wordType :: Type
wordType = I wordsizeg
longType :: Type
longType = I longsizeg

sConcat :: [String] -> String
sConcat [] = ""
sConcat (s : l) = s ++ " " ++ sConcat l

int = "BitVec["++(show wordsize)++"]"
l_int = "BitVec["++(show longsize)++"]"
mem = "mem"
memType = sConcat["(Array",int,int,")"]
list = "list"

gDecl :: String -> [String] -> String -> String
gDecl f args ret = sConcat ["(declare-fun",f,"(",sConcat args,")",ret,")"]

gDeclTyp :: String -> [String] -> String
gDeclTyp t cons =
    sConcat ["(declare-datatypes ((",t,sConcat cons,")))"]

gAssert :: String -> String
gAssert for = sConcat ["(assert ", for, ")"]

gNeq :: String -> String -> String
gNeq a b = sConcat ["(not (= ",a,b,"))"]

gApp :: String -> String -> String
gApp s1 s2 = "("++s1++" "++s2++")"

{-Declarations for all of the free parameters and allocations -}
generateConstants :: (Set String,Set String) -> String
generateConstants (params,allocs) = 
    let addDeclr = \curConst curStr -> gDecl curConst [] int ++ "\n" ++ curStr in
    let declarations = fold addDeclr "" params in
    let alloc_restrictions = fold (\p str -> (forceParamNeq p params) ++"\n"++ str) "" allocs in
    sConcat [declarations,alloc_restrictions]

{-Assert that a parameter is distinct-}
forceParamNeq :: String -> Set String -> String
forceParamNeq p pSet =
    let addConstraint curParam curStr = 
            if (p==curParam) 
            then curStr 
            else ((gAssert (gNeq p curParam)) ++ curStr) 
        in
    fold addConstraint "" pSet
    

allocLoc :: Int -> String
allocLoc i = "_alloc"++(show i)

{-uninterpreted symbols-}
--Theory for the uninterpreted symbol phi

phiTheory nam typ =
    let phiDef = gDecl nam ["bool",typ,typ] typ
        phiAx1 = gAssert $ "(forall (x bool) (y "++typ++") (= ( "++nam++" x y y ) y))"
        phiAx2 = gAssert $ "(forall (y "++typ++") (z "++typ++") (= ( "++nam++" true y z ) y) ) "
        phiAx3 = gAssert $ "(forall (y "++typ++") (z "++typ++") (= ( "++nam++" false y z ) z) ) "
    in sConcat [phiDef, "\n", phiAx1, "\n", phiAx2, "\n", phiAx3]

listTheory = 
    let cons1 = "(nil)" 
        cons2 = "(cons (hd Int) (tl "++list++"))" in
        gDeclTyp list [cons1,cons2]

list_to_str:: [String] -> String
list_to_str =
    foldr (\i s -> ("(cons "++(i)++" "++s++")")) "(nil)"

gepTheory =
    let gepDef = (gDecl "gep" [int,list] int) in
    let noAlias1 = gAssert ("(forall "++(sConcat[(gApp "x" int),(gApp "y" int),(gApp "l1" list)])
                    ++" (=> (not (= x y)) (not (= x (gep y l1)))))") in
    let noAlias2 = gAssert ("(forall "++
                    (sConcat[(gApp "x" int),(gApp "y" int),(gApp "l1" list),(gApp "l2" list)])
                    ++" (=> (not (= x y)) (not (= (gep x l1) (gep y l2)))) )") in
    sConcat [gepDef,"\n",noAlias1,"\n",noAlias2]

{-Ints to bitvectors. Single bits are booleans-}
translateInt :: Int -> Integer -> String
translateInt 1 n=
    if (n==1) then "true"
        else if (n==0) then "false"
            else "badBoolean"

translateInt wSize n = 
    let pn = (if n<0 then 2^wSize+n else n) in
    "bv"++(show pn)++"["++(show wSize)++"]"

translateBinOp :: BinOp -> String
translateBinOp Add = "bvadd"
translateBinOp Sub = "bvsub"
translateBinOp Mul = "bvmul"
translateBinOp URem = "bvurem"
translateBinOp SRem = "bvsmod"
translateBinOp Shl = "bvshl"
translateBinOp LShr = "bvlshr"
translateBinOp AShr = "bvashr"
translateBinOp And = "bvand"
translateBinOp Or = "bvor"
translateBinOp Xor = "bvxor"
translateBinOp UDiv = error "(translateBinOp, unsigned division)"
translateBinOp SDiv = error "(translateBinOp, signed division)"
translateBinOp _ = error "(translateBinOp, floating point operation)"

translateCmpOp :: CmpOp -> String
translateCmpOp MD.Syntax.GDSA.EQ = "="
translateCmpOp NE = error "GenerateSmt: Cannot blindly generate not equal"
translateCmpOp UGT = "bvugt"
translateCmpOp UGE = "bvuge"
translateCmpOp ULT = "bvult"
translateCmpOp ULE = "bvule"
translateCmpOp SGT = "bvsgt"
translateCmpOp SGE = "bvsge"
translateCmpOp SLT = "bvslt"
translateCmpOp SLE = "bvsle"

translateOpr :: Opr -> String
translateOpr (Bop o) = translateBinOp o
translateOpr (Cmp o) = translateCmpOp o
translateOpr (FCmp _) = error "(translateOpr, floating point operation)"

{-***Main Functions***-}

{-Key Function: Converts values to SMT strings-}
translateValue::ValueGraph -> Type -> Value -> String
translateValue _ _ (Param i) = 
    if ((show i)=="$1")
        then mem
        else tail (show i)
translateValue _ _ (Memory _) = error "Memory Not implemented"
translateValue _ (I iType) (CV (Const (Int i))) = translateInt (fromIntegral iType) i
translateValue _ (I iType) (CV (Const Undef)) = "undef"
translateValue _ (I iType) (CV (Const Null)) = translateInt (wordsize) 0

translateValue vg ty (CV (Conv Trunc (I n) v1 (I m))) =
    let s1 = translateValue vg (I n) (fetchVal vg v1) in
    sConcat["(extract["++(show (m-1))++":0]",s1,")"]
translateValue vg ty (CV (Conv ZExt (I n) v1 (I m))) =
    let s1 = translateValue vg (I n) (fetchVal vg v1) in
    sConcat["(zero_extend["++(show (m-n))++"]",s1,")"]
translateValue vg ty (CV (Conv SExt (I n) v1 (I m))) =
    let s1 = translateValue vg (I n) (fetchVal vg v1) in
    sConcat["(sign_extend["++(show (m-n))++"]",s1,")"]
translateValue vg (I iType) (CV (Conv PtrtoInt (Pointer pty) v1 (I m))) =
    translateValue vg (Pointer pty) (fetchVal vg v1)
translateValue vg (Pointer pType) (CV (Conv InttoPtr (I n) v1 (Pointer pty))) =
    translateValue vg (I n) (fetchVal vg v1)
translateValue vg ty (CV (Conv Bitcast ty1 v ty2)) =
    translateValue vg ty1 (fetchVal vg v)

translateValue vg ty (CV (BinOp (Cmp NE) s t v1 v2)) =
    sConcat ["(not",translateValue vg ty (CV (BinOp (Cmp MD.Syntax.GDSA.EQ) s t v1 v2)),")"]

translateValue vg ty (CV (BinOp opr s t v1 v2)) =
    let s1 = translateValue vg t (fetchVal vg v1)
        s2 = translateValue vg t (fetchVal vg v2) in
    (sConcat ["(", translateOpr opr, s1, s2, ")"])

translateValue vg ty (CV (Proj Val ai)) =
    translateValue vg (Pointer ty) (fetchVal vg ai)
translateValue vg ty (CV (Proj Mem ai)) =
    translateValue vg ST (fetchVal vg ai)

translateValue vg (Pointer ty) v@(CV (Alloc _ _ m)) =
    allocLoc (fetchKey vg v)
translateValue vg (ST) (CV (Alloc _ _ m)) =
    translateValue vg ST (fetchVal vg m)

translateValue vg ty (CV (Load lTy p m)) =
    let pStr = translateValue vg lTy (fetchVal vg p)
        mStr = translateValue vg ST (fetchVal vg m) in
    sConcat ["(select",mStr,pStr,")"]

translateValue vg ty (CV (Store sTy v p m)) =
    let vVal = translateValue vg sTy (fetchVal vg v)
        pStr = translateValue vg (Pointer sTy) (fetchVal vg p)
        mStr = translateValue vg ST (fetchVal vg m) in
    sConcat["(store",mStr,pStr,vVal,")"]

translateValue vg ty (CV (Select cond v1 v2)) =
    let s1 = translateValue vg (I 1) (fetchVal vg cond)
        s2 = translateValue vg ty (fetchVal vg v1)
        s3 = translateValue vg ty (fetchVal vg v2) in
    sConcat ["(phi",s1,s2,s3,")"]

{-Breaking up the phi arms into nested ternary phi statements-}
translateValue vg ty (CV (Phi pTy arms)) =
    let phistr = if (pTy == ST) then "phimem" else "phi" in
    case arms of
        [] -> error "empty phi"
        a:[] -> translateValue vg pTy (fetchVal vg (value a))
        a:tl -> sConcat ["(",phistr,translateGuards vg (guard a), 
                    translateValue vg pTy (fetchVal vg (value a)),
                    translateValue vg pTy (CV (Phi pTy tl)),")"]

translateValue vg ty (CV (GetElemPtr gtyp p is)) =
    let s1 = translateValue vg gtyp (fetchVal vg p) in
    let trans_elm i = "(bv2int[Int] "++(translateValue vg longType (fetchVal vg i))++")" in
    let s2 = list_to_str (Prelude.map trans_elm is) in
    sConcat ["(gep ",s1,s2,")"]

translateValue vg ty curVal =
    error ("translate unknown value: "++(show curVal))

{-Combine the guards into a single boolean expression -}
translateGuards :: ValueGraph -> [Int] -> String
translateGuards vg gs =
    case gs of
        [curG] -> translateValue vg (I 1) (fetchVal vg curG)
        curG:tl -> sConcat ["(and",translateValue vg (I 1) (fetchVal vg curG),
            translateGuards vg tl, ")"]

unionpair :: (Set String,Set String)-> (Set String,Set String) -> (Set String, Set String)
unionpair (s11,s12) (s21,s22) =
    (union s11 s21,union s12 s22)

getParamFunc::ValueGraph -> Value -> (Set String, Set String) -> (Set String, Set String)
getParamFunc vg (Param i) c =
    let iStr = show i in
    if (iStr == "$1") 
        then c
        else (unionpair (singleton (tail iStr),empty) c)
getParamFunc vg aV@(CV (Alloc _ _ _)) c =
    let newASet = singleton (allocLoc (fetchKey vg aV)) in
    unionpair (newASet,newASet) c
getParamFunc vg _ c = c

getParams::ValueGraph -> (Set String,Set String)
getParams vg =
    let vList = foldr (\(a,b) c -> b:c) [] (alist vg) in
    foldr (getParamFunc vg) (singleton ("undef"),empty) vList

smallLoadStoreFunc::ValueGraph -> Int -> Value -> ValueGraph
smallLoadStoreFunc vg vi (CV (Load (Pointer (I iSize)) p m)) =
    if (iSize == wordsizeg) then vg else
        let (vg1,vi1) = insertValue (CV (Load (Pointer wordType) p m)) vg in
        alterValue vi (CV (Conv Trunc wordType vi1 (I iSize))) vg1

smallLoadStoreFunc vg vi (CV (Store (I iSize) v p m)) =
    if (iSize == wordsizeg) then vg else
        let (vg1,vi1) = insertValue (CV (Conv ZExt (I iSize) v wordType)) vg in
        alterValue vi (CV (Store wordType vi1 p m)) vg1

smallLoadStoreFunc vg _ _ = vg

preprocess vg =
    foldr (\(vi,vv) vg -> smallLoadStoreFunc vg vi vv) vg (alist vg)
