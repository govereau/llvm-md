{-# LANGUAGE PatternGuards, DeriveFunctor, DeriveFoldable, DeriveTraversable #-}
{-|
  Description : GDSA abstract syntax.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Abstract syntax for GDSA programs and symbolic values.
-}
module MD.Syntax.GDSA
  ( module MD.Syntax.Enum
  , module MD.Syntax.GDSA
  , Ident(..), Const(..), Type(..)
  )
where
import Prelude hiding (concat, concatMap, foldl)
import Data.List (intersperse)
import Data.Maybe
import Data.Foldable
import Data.Traversable
import MD.Syntax.Enum
import MD.Syntax.LLVM (Ident(..), Const(..), Type(..))

-------------------------------------------------------------------------------
-- | GDSA blocks

data GBlock = GBlock
   { label      :: Label
   , loopHeader :: Maybe (Label,[Label]) -- entry label, labels of blocks
   , phis       :: [(Ident, Type, [(Label,Term)])]
   , etas       :: [(Ident, Ident, Label, [Label])]  -- new id, old id, dominator target, loop blocks
   , rules      :: [RR]
   , cfgpre     :: [Label]  -- CFG predecessors
   , cfgsuc     :: [Label]  -- CFG successors
   , dfn        :: Int      -- depth first numbering
   , doms       :: [Label]  -- dominators
   , idom       :: Label    -- immediate dominator
   , pdoms      :: [Label]  -- post dominators
   , pdom       :: Label    -- immediate post dominator
   , children   :: [Label]  -- dominator tree children
   , mem_in     :: Int
   , mem_out    :: Int
   , control    :: Control
   }

instance Eq GBlock where
    b1 == b2 = label b1 == label b2
instance Ord GBlock where
    compare b1 b2 = compare (dfn b1) (dfn b2)

type Label = Int
data RR    = RR { rrIdent :: Ident
                , rrTerm  :: Term }
             deriving Eq

data Control
   = Ret Term
   | Seq Label
   | MBr Term Type Label [(Term,Label)]
     deriving Show

-------------------------------------------------------------------------------
-- printing gblocks

instance Show GBlock where
 show b =
   show (label b) ++":"++ show (dfn b) ++ (if isJust (loopHeader b) then ":" else " ") ++
   show (cfgpre b) ++ show (cfgsuc b) ++ " "++
   show (doms b) ++ show (pdoms b) ++
   " ("++ show (mem_in b) ++ " -> "++ show (mem_out b) ++")\n"++
   " "++ show (loopHeader b) ++ "\n"++
   shphi b ++ sheta b ++ show (rules b) ++ show (control b)

 showList bs _ = concat $ intersperse "\n\n" $ map show bs

shphi :: GBlock -> String
shphi b = unlines $ flip map (phis b) $ \(i,t,l) ->
          " PHI "++ show i ++"::"++ show t ++" <- "++ show l

sheta :: GBlock -> String
sheta b = unlines $ flip map (etas b) $ \(x,y,l,ls) ->
          " ETA "++ show x ++" <- "++ show y ++" from "++ show l ++ show ls

instance Show RR where
    show (RR i t) = show i ++ " -> " ++ show t
    showList l _  = unlines (map ((' ':) . show) l)

-------------------------------------------------------------------------------
-- GDSA/Symbolic Term language

data Common a
   = Const Const
   | Proj PI a

   | GetElemPtr Type a [a]
   | BinOp Opr String Type a a
   | Conv ConvOp Type a Type
   | Select a a a
   | Extract Type a [Integer]

   | Alloc Type a a
   | Load  Type a a
   | Store Type a a a
   | Call a [a] a

   | Phi Type [PhiArm a]
   | Mu Type a a
   | Eta a a
   | Returns (a,a)
     deriving (Eq,Ord,Functor,Foldable,Traversable,Show)

data PI = Val | Mem deriving (Eq,Ord,Show)
data PhiArm a = PhiArm { guard :: [a] , value :: a }
                deriving(Eq,Ord,Functor,Foldable,Traversable)

instance Show a => Show (PhiArm a) where
    show (PhiArm gs v) = show gs ++" -> "++ show v

data Term
   = Var Ident
   | CT (Common Term)
     deriving (Eq,Ord,Show)

data Value
   = Param Ident
   | Memory [Cell]
   | CV (Common Int)
     deriving (Eq,Ord)

data Cell = Cell
     { cellType    :: Type
     , cellSize    :: Integer
     , cellPointer :: Int
     , cellValue   :: Int
     } deriving (Eq,Ord)

instance Show Value where
    show (Param i)    = show i
    show (Memory l)   = "{"++ concatMap show l ++ "}"
    show (CV t)       = show t

instance Show Cell where
    show (Cell ty n pp pv) = show pp ++"->"++ show pv ++"::"++
                             show ty ++"<"++ show n ++">"

valname :: Value -> String
valname (Param i)    = show i
valname (Memory _)   = "Memory"
valname (CV term)    = case term of
  Const c            -> show c
  Proj p _           -> show p
  GetElemPtr ty _ _  -> "gep"++show ty
  BinOp o s ty _ _   -> show o ++ s ++ show ty
  Conv op t1 _ t2    -> show op++show t1++show t2
  Select _ _ _       -> "Select"
  Extract ty _ _     -> "Extract"++show ty
  Alloc ty _ _       -> "Alloc"++show ty
  Load ty _ _        -> "Load"++show ty
  Store ty _ _ _     -> "Store"++show ty
  Call _ _ _         -> "Call"
  Phi ty _           -> "Phi"++show ty
  Mu ty _ _          -> "Mu"++show ty
  Eta _ _            -> "Eta"
  Returns _          -> "Returns"

-------------------------------------------------------------------------------
-- | free variables

fvs :: Term -> [Ident]
fvs (Var i)         = [i]
fvs (CT t)          = foldMap fvs t

fps :: Value -> [Ident]
fps (Param i) = [i]
fps _         = []

refs :: Value -> [Int]
refs (Param _)    = []
refs (Memory l)   = foldl (\rs c -> cellPointer c:cellValue c:rs) [] l
refs (CV t)       = foldMap (\x -> [x]) t

fivs :: Term -> [Ident]
fivs t = mapMaybe isInd (fvs t)
 where
   isInd :: Ident -> Maybe Ident
   isInd (Ident _) = Nothing
   isInd (Z i)     = Just i
   isInd (N i)     = Just i
   isInd (P i)     = Just i
