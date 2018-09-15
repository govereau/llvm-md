{-|
  Description : UTF8 character parsers.
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Combinators for parsing UTF8 character data.
-}
module MD.Parser.Parsec.Char
  ( satisfyWord, satisfy, string
  , char, notChar, anyChar
  , oneOfWord, noneOfWord
  , oneOf, noneOf
  , space , newline, tab, spaces, line
  , letter, upper, lower, alphaNum
  , digit, hexDigit, octDigit
  , printable
  , decimal, octal, hexadecimal
  , nat, int, float
  )
where
import Data.Word
import Data.Char
import MD.Parser.Parsec.Prim
import MD.Parser.Parsec.Combinator

-------------------------------------------------------------------------------
-- Primitive character parsers

satisfyWord :: (Word8 -> Bool) -> Parser st Char
satisfyWord f = tokenPrim True test
 where
   test w = if f w then Just (chr $ fromIntegral w) else Nothing

satisfy :: (Char -> Bool) -> Parser st Char
satisfy f = tokenPrim True test
 where
   test w = let c = chr (fromIntegral w) in
            if f c then Just c else Nothing

string :: String -> Parser st String
string s = do { tokens True $ map (fromIntegral . ord) s ; return s }

-------------------------------------------------------------------------------
-- Basic combinators

char, notChar :: Char -> Parser st Char
char    c = satisfy (== c) <?> show [c]
notChar c = satisfy (/= c)

anyChar :: Parser st Char
anyChar = satisfyWord (const True)

oneOfWord, noneOfWord :: [Word8] -> Parser st Char
oneOfWord  ws = satisfyWord (\w -> elem w ws)
noneOfWord ws = satisfyWord (\w -> not (elem w ws))

oneOf, noneOf :: [Char] -> Parser st Char
oneOf  cs = satisfy (\c -> elem c cs)
noneOf cs = satisfy (\c -> not (elem c cs))

space, newline, tab :: Parser st Char
space   = oneOfWord [0x9,0xA,0xB,0xC,0xD,0x20,0xA0] <?> "space"
newline = satisfyWord (==0xA) <?> "new-line"
tab     = satisfyWord (==0x9) <?> "tab"

spaces :: Parser st ()
spaces = skipMany1 space         <?> "white space"

line :: Parser st String
line = manyTill anyChar newline  <?> "single line"

letter, upper, lower, alphaNum :: Parser st Char
letter   = satisfy (isAlpha)     <?> "letter"
upper    = satisfy (isUpper)     <?> "uppercase letter"
lower    = satisfy (isLower)     <?> "lowercase letter"
alphaNum = satisfy (isAlphaNum)  <?> "letter or digit"

digit, hexDigit, octDigit :: Parser st Char
digit    = satisfy isDigit    <?> "digit"
hexDigit = satisfy isHexDigit <?> "hexadecimal digit"
octDigit = satisfy isOctDigit <?> "octal digit"

printable :: Parser st Char
printable = satisfy isPrint <?> "printable character"

-------------------------------------------------------------------------------
-- Number parsers

digits :: Parser st Char -> Parser st [Int]
digits p = many1 (liftM digitToInt p)

integral :: Integer -> Parser st Char -> Parser st Integer
integral base p =
    do { ds <- digits p
       ; return $! foldl (\x d -> base*x + toInteger d) 0 ds
       }

fractional :: Parser st Float
fractional =
    do { char '.'
       ; ds <- digits digit
       ; return $! foldr (\d x -> (x + fromIntegral d) / 10) 0 ds
       }

decimal :: Parser st Integer
decimal = integral 10 digit

octal :: Parser st Integer
octal = integral 8 octDigit

hexadecimal :: Parser st Integer
hexadecimal = integral 16 hexDigit

nat :: Parser st Integer
nat = try hex <|> try oct <|> decimal
 where
   hex = do { char '0'; oneOf "xX"; hexadecimal }
   oct = do { char '0'; oneOf "oO"; octal }

int :: Parser st Integer
int = do { f <- option id (plus <|> minus)
         ; liftM f nat
         }
    where
      plus  = do { char '+'; return id     }
      minus = do { char '-'; return negate }

float :: Parser st Float
float = do { d <- liftM fromInteger (integral 10 digit)
           ; f <- fractional
           ; return (d + f)
           }
