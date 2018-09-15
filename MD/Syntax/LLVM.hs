{-|
  Description : LLVM abstract syntax.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Abstract syntax for LLVM source programs.
-}
module MD.Syntax.LLVM
  ( module MD.Syntax.Enum
  , module MD.Syntax.LLVM
  )
where
import Data.List
import MD.Syntax.Enum

-------------------------------------------------------------------------------
-- basic types shared betweem LLVM and GDSA

data Ident
   = Ident String
   | Z Ident  -- x_0
   | N Ident  -- x_n
   | P Ident  -- x_(n-1)
     deriving (Eq,Ord)

instance Show Ident where
    show (Ident s) = s
    show (Z i)     = show i ++ "_0"
    show (N i)     = show i ++ "_n"
    show (P i)     = show i ++ "_(n-1)"

data Const
   = Null | Undef
   | Int Integer
   | Float String  -- we don't handle float right now
     deriving (Eq,Ord)

instance Show Const where
    show Null      = "null"
    show Undef     = "undef"
    show (Int i)   = "int " ++ show i
    show (Float f) = "float " ++ show f

-------------------------------------------------------------------------------
-- LLVM module structure

data Module = Module [Decl] deriving (Eq)

data Decl
   = Target | Declare  -- ignored
   | Global Ident Type Value
   | TypeDef Ident Type
   | Function
     { fLinkage     :: Maybe Linkage
     , fVisibility  :: Maybe Visibility
     , fCCoonc      :: Maybe CConv
     , fAttr        :: [Attr]
     , fRetType     :: Type
     , fName        :: String
     , fArgs        :: [Argument]
     , fBlocks      :: [Block]
     } deriving Eq

isFunction :: Decl -> Bool
isFunction (Function {}) = True
isFunction _ = False

data Argument = Arg Type [Attr] Ident | Dots deriving (Eq)

-- | LLVM Types
-- These types are also used in the symbolc form, and for that we add a
-- state variable type "ST".

data Type
   = I Integer
   | F32 | F64 | F128 | F80 | F128_PPC
   | Void | Label | MetaData | Opaque
   | TypeName Ident
   | Array   { num_elements :: Integer, base_type :: Type }
   | Vector  { num_elements :: Integer, base_type :: Type }
   | Struct  { element_types :: [Type] }
   | PStruct { element_types :: [Type] }
   | Pointer { base_type :: Type }
   | FunTy   { return_type :: Type
             , var_args :: Bool
             , argments :: [(Type,[Attr])]
             }
   | ST -- ^ GDSA state variable type
     deriving (Eq,Ord)

data Value
   = Var Ident
   | Const Const
   | ConstExpr Expr
     deriving (Eq,Ord)

data Expr
   = GetElemPtr TV [TV]
   | BinOp Opr String Type Value Value
   | Conv ConvOp TV Type
   | Select TV TV TV
   | Extract TV [Integer]
     deriving (Eq,Ord)

data TV = TV Type Value deriving (Eq,Ord)

-------------------------------------------------------------------------------
-- | LLVM basic blocks

data Block
   = Block { blockName   :: String
           , blockIndex  :: Int
           , blockMiddle :: Instructions
           , blockEnd    :: ControlInst
           } deriving Eq

instance Ord Block where
    compare x y = compare (blockIndex x) (blockIndex y)

-- | Block labels

data Label = LI Int | LS String deriving Eq

-- instructions

type Instructions = [Instruction]
data Instruction
   = Instruction { boundId :: Maybe Ident
                 , rhsExpr :: RHS
                 } deriving Eq

data RHS
   = MemOp MemoryInst
   | Expr Expr
   | Phi Type [(Value,Label)]
   | Call Value [TV]
     deriving Eq

data MemoryInst
   = Alloca Type Value Integer
   | Malloc Type TV
   | Free TV
   | Load Bool TV
   | Store Bool TV Value
     deriving Eq

data ControlInst
   = Unreachable
   | Return (Maybe TV)
   | Br Label
   | CBr Value Label Label
   | Switch TV Label [(TV,Label)]
     deriving Eq

blockTargets :: Block -> [Label]
blockTargets (Block { blockEnd = ci }) = targets ci

targets :: ControlInst -> [Label]
targets ci = case ci of
  Unreachable -> []
  Return _ -> []
  Br x -> [x]
  CBr _ a b -> [a,b]
  Switch _ l xs -> l : map snd xs

-------------------------------------------------------------------------------
-- Some show instances

instance Show Module where
    show (Module ds) = unlines (map show ds)

instance Show Decl where
    show Target  = "TARGET"
    show Declare = "DECLARE"
    show (Global i t v) = "global "++ show i ++"::"++ show t ++" = "++ show v
    show (TypeDef i t) = show i ++" = "++ show t
    show (Function { fName = n, fArgs = ax, fBlocks = bs }) =
        n ++ show ax ++"\n"++ show bs

instance Show Argument where
    show (Arg t ax i) = unwords [show t, show ax, show i]
    show Dots         = "..."
    showList l _      = "("++ concat (intersperse ", " $ map show l) ++ ")"

instance Show Type where
    show (I i)        = "i" ++ show i
    show F32          = "float32"
    show F64          = "float64"
    show (TypeName i) = show i
    show (Pointer t)  = show t ++ "*"
    show ST           = "ST"
    show _ = "?"

instance Show Value where
    show (Var v)       = show v
    show (Const c)     = show c
    show (ConstExpr e) = show e

instance Show Expr where
    show (GetElemPtr (TV _ v) l) = "GetElemPtr ("++ show v ++")"++ show (map (\(TV _ x) -> x) l)
    show (BinOp op flg t v1 v2)  = show op++flg++show t ++ "("++ show v1 ++ ", "++ show v2 ++")"
    show (Conv op (TV t v1) v2)  = show op++show t ++ "("++ show v1 ++ ", "++ show v2 ++")"
    show (Select _ _ _)          = "select ??"
    show (Extract _ _)           = "extract ??"

instance Show TV where
    show (TV t v) = show t ++ " " ++ show v


instance Show Block where
    show (Block l n ins ci) =
        ('%':l) ++"("++ show n ++")\n"++ show ins ++ "  "++ show ci

    showList bs _ = concat $ intersperse "\n\n" $ map show bs

instance Show Label where
    show (LI i) = show i
    show (LS s) = s


instance Show Instruction where
    show (Instruction Nothing  rhs) = show rhs
    show (Instruction (Just x) rhs) = show x ++ " <- " ++ show rhs

    showList l _ = unlines (map (("  "++) . show) l)

instance Show RHS where
    show (MemOp mi)  = show mi
    show (Expr e)    = show e
    show (Phi t vls) = unwords ["phi", show t, show vls]
    show (Call s ax) = "call " ++ show s ++ show ax

instance Show MemoryInst where
    show (Alloca t n _)         = "alloc "++ show t++" "++ show n
    show (Load _ (TV _ v))      = "load "++ show v
    show (Store _ (TV _ v) v2)  = "store "++ show v ++ " "++ show v2
    show (Malloc _ _)           = "MALLOC"
    show (Free _)               = "FREE"

instance Show ControlInst where
    show Unreachable              = "unreachable"
    show (Return Nothing)         = "return"
    show (Return (Just (TV _ v))) = "return " ++ show v
    show (Br l)                   = "br "++ show l
    show (CBr v l1 l2)            = "cbr "++ show v ++" "++ show l1 ++","++ show l2
    show (Switch tv l arms) =
        unwords $ ["switch", arm(tv,l), "{"] ++ map arm arms ++ ["}"]
            where arm (TV _ v,l') = show v ++" -> "++ show l'
