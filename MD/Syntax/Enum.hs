{-# LANGUAGE TemplateHaskell #-}
{-|
  Description : Enumerations.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module defines a number of enumerations that are used in our abstract
  syntax. We define these here because these data types will have some
  additional data and functions defined using basic meta-programming
  techniques.
-}
module MD.Syntax.Enum where
import MD.Syntax.Meta

data Opr = Bop BinOp | Cmp CmpOp | FCmp FCmpOp
           deriving (Eq,Ord)

instance Show Opr where
    show (Bop bop) = show bop
    show (Cmp cmp) = show cmp
    show (FCmp f)  = show f

data BinOp
   = Add | FAdd | Sub | FSub
   | Mul | FMul | UDiv | SDiv | FDiv
   | URem | SRem | FRem
   | Shl | LShr | AShr | And | Or | Xor
     deriving (Eq,Ord)

data CmpOp = EQ | NE
           | UGT | UGE | ULT | ULE
           | SGT | SGE | SLT | SLE
             deriving (Eq,Ord)

data FCmpOp = TRUE | FALSE
            | Oeq | Ogt | Oge | Olt | Ole | One | ORD
            | Ueq | Ugt | Uge | Ult | Ule | Une | Uno
              deriving (Eq,Ord)

data ConvOp
   = Trunc
   | ZExt | SExt
   | FPTrunc | FPExt
   | FPtoUI | FPtoSI
   | UItoFP | SItoFP
   | PtrtoInt | InttoPtr
   | Bitcast
     deriving (Eq,Ord)

data Linkage
   = Private
   | Linkage_private
   | Internal
   | Available_externally
   | Linkonce
   | Weak
   | Common
   | Appending
   | Extern_weak
   | Linkonce_odr
   | Weak_odr
   | Dllimport
   | Dllexport
     deriving (Eq,Ord)

data Visibility = Default | Hidden | Protected
                  deriving (Eq,Ord)

data CConv = CCC | FastCC | ColdCC
             deriving (Eq,Ord)

data Attr = ZeroExt | SignExt
          | InReg | ByVal | SRet
          | NoAlias | NoCapture
          | Nest
            deriving (Eq,Ord)

-- generated association lists and show instances

metaDecls [ ''ConvOp, ''CmpOp, ''FCmpOp, ''BinOp
          , ''Linkage, ''Visibility, ''CConv, ''Attr
          ]
