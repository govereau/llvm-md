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

--Helper functions and constants

wordsize :: Integer
wordsize = 32

lp = "("
rp = ")"
co = ","
nl = "\n"
sp = " "
phi = "phi"
gep = "gep"
alloc = "alloc"
store = "store"
load = "load"
call = "call"
omega = "omega"
int = "BitVec[" ++ show wordsize ++ "]"
bool = "bool"
mem = "mem"
memType = "(Array BitVec[32] BitVec[32])"

-- sConcat [a,b,...,z] = "a b ... z" 
sConcat :: [String] -> String
sConcat [] = ""
sConcat (s : l) = s ++ " " ++ sConcat l

--gForall x t f = "( forall ( x t ) ( f ) )"
gForall :: String -> String -> String -> String
gForall var typ for = sConcat [lp, "forall", lp, var, typ, rp, lp, for, rp, rp]

--gAssert a = "( assert ( a ) )"
gAssert :: String -> String
gAssert for = sConcat [lp, "assert", lp, for, rp, rp]

--gImply f g = "( => ( f ) ( g ) )"
gImply :: String -> String -> String
gImply f1 f2 = sConcat [lp, "=>", lp, f1, rp, lp, f2, rp, rp]

--gAnd
gAnd :: String -> String -> String
gAnd f1 f2 = sConcat [lp, "and", lp, f1, rp, lp, f2, rp, rp ]

--gOr
gOr :: String -> String -> String
gOr f1 f2 = sConcat [lp, "or", lp, f1, rp, lp, f2, rp, rp ]

--gNot
gNot :: String -> String
gNot f = sConcat [lp, "not", lp, f, rp, rp]

--gEq
gEq :: String -> String -> String
gEq f1 f2 = sConcat [lp, "=", lp, f1, rp, lp, f2, rp, rp ]

--gDecl n args ret "( declare-fun n ( args ) ret )"
gDecl :: String -> [String] -> String -> String 
gDecl n args ret = sConcat [lp, "declare-fun", n, lp, sConcat args, rp, ret, rp]

--gDef n args ret t = " define-fun n ( args ) ret t"
gDef :: String -> [String] -> String -> String -> String
gDef n args ret def = sConcat [lp, "define-fun", n, lp, sConcat args, rp, ret, def, rp]

mkErrorMsg m = error $ sConcat ["SMT-LIB script generation: NIY", lp, m, rp]

--Preprocessing

sizeOf :: Type -> Integer
sizeOf (I 64) = 8
sizeOf (I 32) = 4
sizeOf (I 16) = 2
sizeOf (I 8) = 1
sizeOf F32 = 4
sizeOf F64 = 8
sizeOf F128 = 16
sizeOf F80 = 10
sizeOf (Pointer _) = div wordsize 8    
sizeOf (Array size typ) = size * sizeOf typ
sizeOf (Vector size typ) = size * sizeOf typ
sizeOf (Struct l) = foldl (\siz typ -> siz + sizeOf typ) 0 l   
sizeOf _ = mkErrorMsg "sizeof"

computeIdx :: Type -> Type -> [Term] -> Term
computeIdx _ _ [] = Atom ( Int 0)
computeIdx rtyp (Array _ typ) (idx : ids) = BinOp (Bop Add) "nsw" rtyp offset (computeIdx rtyp typ ids)
           where offset = BinOp (Bop Mul) "nsw" rtyp (Atom (Int (sizeOf typ))) idx
computeIdx rtyp (Struct (typ : l)) ((Atom (Int idx)) : ids) = BinOp (Bop Add) "nsw" rtyp offset (computeIdx rtyp (Struct l) ((Atom ( Int (idx - 1))) : ids))
           where offset = Atom ( Int (sizeOf typ))
computeIdx _ _ _ = mkErrorMsg "computeIdx"

computeIdxStart :: Type -> [Term] -> Term
computeIdxStart (Pointer typ) (idx : ids) = BinOp (Bop Add) "nsw" typ offset (computeIdx typ typ ids)
           where offset = BinOp (Bop Mul) "nsw" typ (Atom (Int (sizeOf typ))) idx
computeIdxStart _ _ = mkErrorMsg "GEP does not star with a pointer type"

preprocess :: Term -> Term
preprocess (GetElemPtr (Pointer typ) t ids) = addr
           where toInt = (Conv PtrtoInt (Pointer typ) t typ)
                 intAddr = BinOp (Bop Add) "nsw" typ toInt (computeIdxStart (Pointer typ) ids) 
                 addr = (Conv InttoPtr typ intAddr (Pointer typ))           
preprocess (Select t0 t1 t2) = undefined --Phi Opaque [t0] t1 t2
preprocess t = t

--Translation of a symbolic value to a string representing an SMT term

zeros :: Integer -> String
zeros 0 = ""
zeros n | n > 0 = zeros (n-1) ++ "0"
zeros _ = mkErrorMsg "zeros received a negative Integer."

ones :: Integer -> String
ones 0 = ""
ones n | n > 0 = ones (n-1) ++ "1"
ones _ = mkErrorMsg "ones received a negative Tnteger."

translateInt :: Integer -> String
translateInt 0 = ""
translateInt n | n > 0 = translateInt (div n 2) ++ (if (mod n 2) == 0 then "0" else "1")
translateInt _ = mkErrorMsg "No negative integers."

translateAtom :: Atom -> (String, Set String)
translateAtom (Var (Ident s)) = (tail s, singleton (tail s))
translateAtom (Int i) | i >= 0 = ("bv" ++ (zeros  (wordsize - (fromIntegral (length si)))) ++ si, empty)
              where si = translateInt i
translateAtom (Int i) | i < 0 = ("bv" ++ (ones  (wordsize - (fromIntegral (length si)))) ++ si, empty)
              where si = translateInt (-i)
translateAtom _ = mkErrorMsg "translateAtom"

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
translateBinOp UDiv = mkErrorMsg "(translateBinOp, unsigned division)"
translateBinOp SDiv = mkErrorMsg "(translateBinOp, signed division)"
translateBinOp _ = mkErrorMsg "(translateBinOp, floating point operation)"

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
translateOpr (FCmp o) = mkErrorMsg "(translateOpr, floating point operation)"

--translateTerm t returns the denotation of t, the set of variables appearing in t, and the set of "phi replacements", the Integer is used to generate fresh names
translateTerm :: Term -> Integer -> (String,Set String,Set String,Integer)
translateTerm (Atom a) n = (sConcat [lp, s, rp], v, empty, n)
              where (s,v) = translateAtom a 
translateTerm (BinOp (Cmp NE) s _ t1 t2) n = (sConcat [lp, "not", lp, " = ", s1, s2, rp, rp], union v1 v2, union p1 p2, n'')
              where (s1, v1, p1, n') = translateTerm t1 n
                    (s2, v2, p2, n'') = translateTerm t2 n'
translateTerm (BinOp o s _ t1 t2) n = (sConcat [lp, translateOpr o, s1, s2, rp], union v1 v2, union p1 p2, n'')
              where (s1, v1, p1, n') = translateTerm t1 n
                    (s2, v2, p2, n'') = translateTerm t2 n'

{-
translateTerm (Phi _ t1 t2 t3) n = (name, unions [v1, v2, v3, singleton name], unions [p1,p2,p3,singleton form], n''')
              where (s1, v1, p1, n') = -- foldl (\() t -> ) ("",empty,empty,n+1) t1 --translateTerm t1 (n+1)
                    (s2, v2, p2, n'') = translateTerm t2 n'
                    (s3, v3, p3, n''') = translateTerm t3 n''
                    name = "phi" ++ show n
                    form = gAssert $ gOr (gAnd s1 (gEq name s2)) (gAnd (gNot s1) (gEq name s3)) 
-}
translateTerm (Conv Trunc (I n) t (I m)) q = ("(bvand " ++ s ++ mask ++ ")", v, p,n')
              where (s,v,p,n') = translateTerm t q 
                    mask = zeros (wordsize - n) ++ ones (n - m) ++ zeros m
translateTerm (Conv ZExt (I n) t (I m)) q = ("(bvand " ++ s ++ mask ++ ")", v, p,n')
              where (s,v,p,n') = translateTerm t q 
                    mask = "bv" ++ zeros (wordsize - m) ++ ones (m - n) ++ zeros n
translateTerm (Conv SExt (I n) t (I m)) q = (sext s, v, p,n')
              where (s,v,p,n') = translateTerm t q 
                    sext = \s -> "(bvashr (bvshl (" ++ s ++ ") (" ++ fst (translateAtom (Int (wordsize - n))) ++  ")) (" ++ fst (translateAtom (Int (wordsize - m)))  ++ "))"
translateTerm (Conv PtrtoInt _ t _) n = translateTerm t n
translateTerm (Conv InttoPtr _ t _) n = translateTerm t n 
--The type has to be used as the mask because the memory is wordsize addressable
translateTerm (Load typ addr m) n = (sel, union v vm, union p pm, n'')
              where (s,v,p,n') = translateTerm addr n
                    (sm,vm,pm,n'') = translateTerm m n'
                    sel = sConcat [lp, "select", sm, s, rp]  
translateTerm (Store typ val addr m) n = (st, unions [v,vv,vm],unions [p,pv,pm],n''')
              where (s,v,p,n') = translateTerm addr n
                    (sv,vv,pv,n'') = translateTerm val n'
                    (sm,vm,pm,n''') = translateTerm m n''
                    st = sConcat [lp, "store", sm, s, sv]
translateTerm (GetElemPtr _ _ _) _ = mkErrorMsg "GEP after preprocessing." 
translateTerm (Select _ _ _) _ = mkErrorMsg "Select after preprocessing"
translateTerm _ _ = mkErrorMsg "(translateTerm)"

--Generation of an SMT script

generateConstants :: Set String -> String
generateConstants s = fold f "" s 
                  where f = \e s -> gDecl e [] int ++ nl ++ s

generatePhis :: Set String -> String
generatePhis s = fold f "" s
                  where f = \e s -> e ++ nl ++ s

--Theory for the uninterpreted symbol phi
-- phiDef = gDecl phi [bool,int,int] int
-- phiAx1 = gAssert $ gForall "x" bool $ gForall "y" int $ "= ( phi x y y ) y"
-- phiAx2 = gAssert $ gForall "x" bool $ gForall "y" int $ gForall "z" int $ gImply "= x true" "= ( phi x y z ) y"
-- phiAx3 = gAssert $ gForall "x" bool $ gForall "y" int $ gForall "z" int $ gImply "= x false" "= ( phi x y z ) z"
-- phiTheory = sConcat [phiDef, nl, phiAx1, nl, phiAx2, nl, phiAx3, nl]
 
script :: Term -> Term -> String
script t1 t2 = sConcat [--gDef "tr" [] int true, nl,
                        --gDef "fa" [] int false, nl,
                        --phiTheory, 
                        gDecl mem [] memType, 
                        generateConstants (union v1 v2), nl, 
                        generatePhis (union p1 p2), nl,
                        lp, "assert", lp,  "not", lp, " = ", s1, s2, rp, rp, rp, nl, nl, 
                        "(check-sat)", nl, "(model)", nl]
       where (s1, v1, p1, n) = translateTerm (preprocess t1) 0
             (s2, v2, p2, _) = translateTerm (preprocess t2) n
 
