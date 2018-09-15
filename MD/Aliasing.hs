{-# LANGUAGE PatternGuards #-}
{-|
  Description : Aliasing Rules.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module implements the 'mayAlias' relation used by the validator.
-}
module MD.Aliasing
  ( mayAlias
  , Source(..), findPtr, findAlloc )
where
import MD.Syntax.GDSA
import MD.Sharing

mayAlias :: ValueGraph -> Int -> Int -> Bool
mayAlias vg p1 p2
    | Just u1 <- findPtr vg p1
    , Just u2 <- findPtr vg p2, u1 /= u2 = False

    | Just u1 <- findPtr vg p1
    , Just u2 <- findPtr vg p2, u1 == u2
    , Just l1 <- findGEP vg (nodeId u1) p1
    , Just l2 <- findGEP vg (nodeId u2) p2, l1 /= l2 = False

-- sha1
{-
    | Just u1 <- findPtr vg p1
    , Just u2 <- findPtr vg p2, u1 == u2
    , Just l1 <- findGEP vg (nodeId u1) p1
    , Nothing <- findGEP vg (nodeId u2) p2 = False

    | Just u1 <- findPtr vg p1
    , Just u2 <- findPtr vg p2, u1 == u2
    , Nothing <- findGEP vg (nodeId u1) p1
    , Just l2 <- findGEP vg (nodeId u2) p2 = False
-}
-- sha1


    | CV (Const _) <- fetchVal vg p1 = False
    | CV (Const _) <- fetchVal vg p2 = False
mayAlias _ _ _ = True

data Source
   = Global { nodeId :: Int }
   | Local  { nodeId :: Int }
   | Arg    { nodeId :: Int }
     deriving Eq

findPtr :: ValueGraph -> Int -> Maybe Source
findPtr vg u = case fetchVal vg u of
  Param (Ident ('%':_))      -> Just $ Arg u
  Param (Ident ('@':_))      -> Just $ Global u
  CV (Alloc _ _ _)           -> Just $ Local u
  CV (Conv Bitcast _ x _)    -> findPtr vg x
  CV (Proj Val x)            -> findPtr vg x
  CV (GetElemPtr _ x _)      -> findPtr vg x
  _                          -> Nothing

findGEP :: ValueGraph -> Int -> Int -> Maybe [Int]
findGEP vg s u = case fetchVal vg u of
  CV (Conv Bitcast _ x _)        -> findGEP vg s x
  CV (Proj Val x)                -> findGEP vg s x
  CV (GetElemPtr _ x l) | x == s -> Just l
  _                              -> Nothing

findAlloc :: ValueGraph -> Int -> Maybe Int
findAlloc vg u = case fetchVal vg u of
  CV (Alloc _ _ _)        -> Just u
  CV (Conv Bitcast _ x _) -> findAlloc vg x
  CV (Proj Val x)         -> findAlloc vg x
  CV (GetElemPtr _ x _)   -> findAlloc vg x
  _                       -> Nothing
