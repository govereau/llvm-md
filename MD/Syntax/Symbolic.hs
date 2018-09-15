{-|
  Description : Symbolic value abstract syntax.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Abstract syntax for symbolic values.
-}
module MD.Syntax.Symbolic
where
import Control.Monad
import Data.List
import Data.Maybe
import Data.STRef
import MD.Syntax.Enum
import MD.Syntax.LLVM (Ident(..), Atom(..), Type(..))
import MD.Syntax.GDSA(PI(..))

type Const = Int

data Common a
   = Const Const
   | Proj PI a

   | GetElemPtr Type a [a]
   | BinOp Opr String Type a a
   | Conv ConvOp Type a Type
   | Select a a a

   | Alloc Type Integer a
   | Load  Type a a
   | Store Type a a a
   | Call a [a] a

   | Phi Type a a a
     deriving (Eq,Show)

data Term
   = IVar Ident
   | CT (Common Ident)

data SValue s
   = Var (STRef s (SValue s))
   | CV (Common (SValue s))
   | Omega { variable  :: Ident
           , vartype   :: Type
           , condition :: SValue s
           , sequences :: [Sequence s]
           }
     deriving (Eq)

instance Show (SValue s) where show _ = ""

data Sequence s =
    SeqRules String (SValue s) (SValue s)
             deriving (Eq,Show)
