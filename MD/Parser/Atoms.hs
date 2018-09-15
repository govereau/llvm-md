{-|
  Description : Parsers for atoms.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Parsers for identifiers, labels, and other syntax atoms. Unless otherwise
  specified, these parsers do not consume any white space.
-}
module MD.Parser.Atoms
  ( ident, globalId, labelId, label
  , attrs, cconv, visibility, linkage
  )
where
import Data.Char
import MD.Syntax.LLVM
import MD.Parser.Basic

-------------------------------------------------------------------------------
-- Definitions of character classes and reserved symbols and identifiers

-- ignoring quoted identifiers

ident :: P Ident
ident =
    do { c <- local <|> global
       ; n <- token $ (quoted <|> many1 (satisfy idChar))
       ; return (Ident (c:n))
       }
 where
   local  = char '%' >> return '%'
   global = char '@' >> return '@'
   quoted = char '"' >> manyTill anyChar (char '"') >>= \cs -> return cs
   idChar c = isAlphaNum c || c == '$' || c == '.' || c == '_' || c == '-'

labelId :: P Label
labelId = do { char '%'; li <|> ls }
 where
   li = do { n <- token nat
           ; return (LI $ fromIntegral n)
           }
   ls = do { n <- token $ many1 (satisfy lblChar)
           ; return (LS n)
           }

globalId :: P String
globalId = ident >>= \i ->
           case i of
             Ident ('@':s) -> return s
             _ -> fail "non global"

label :: P String
label =
    do { n <- many1 (satisfy lblChar)
       ; symchar ':'
       ; return n
       }

lblChar :: Char -> Bool
lblChar c = isAlphaNum c || c == '.' || c == '_' || c == '-' -- is this right?

attrs :: P [Attr]
attrs = many (try $ enumeration attr_map)

cconv :: P (Maybe CConv)
cconv = opt (enumeration cconv_map)

visibility :: P (Maybe Visibility)
visibility = opt (enumeration visibility_map)

linkage :: P (Maybe Linkage)
linkage = opt (enumeration linkage_map)

opt :: P a -> P (Maybe a)
opt p = option Nothing (liftM Just (try p))
