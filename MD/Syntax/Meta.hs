{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS -fno-warn-missing-signatures #-}
{-|
  Description : Meta-data for enumerations.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  This module provides a meta-function for generating data and show instances
  for enumerations.
-}
module MD.Syntax.Meta ( metaDecls ) where
import Data.Char
import Control.Monad
import Language.Haskell.TH

-- | A meta-function that defines association lists and show instances for a
-- list of simple enumeration types.

metaDecls :: [Name] -> Q [Dec]
metaDecls ns = liftM concat (mapM metaDecl ns)

metaDecl :: Name -> Q [Dec]
metaDecl name =
    do { let s = nameStr name ++ "_map"
       ; let n = mkName s
       ; ~(TyConI (DataD [] _ [] cs [])) <- reify name
       ; t <- [t| [($(conT name), String)] |]
       ; e <- listE (map mapr cs)
       ; d <- [d| show x = case lookup x $(varE n) of
                             Just y  -> y
                             Nothing -> error "meta" |]
       ; return
         [ SigD n t
         , ValD (VarP n) (NormalB e) []
         , InstanceD [] (AppT (ConT $ mkName "Show") (ConT name)) d
         ]
       }

nameStr :: Name -> String
nameStr = map toLower . nameBase

mapr :: Con -> Q Exp
mapr (NormalC n []) = let s = nameStr n in [| ($(conE n), s) |]
mapr _ = fail "invalid enumeration"
