{-|
  Description : Basic parser combinators.
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Basic combinators built from the primitive parsers.
-}
module MD.Parser.Parsec.Combinator
  ( (<?>), (<|>), choice
  , count
  , between
  , option, optional, ignore
  , skipMany1
  , many1
  , sepBy, sepBy1
  , endBy, endBy1
  , sepEndBy, sepEndBy1
  , chainl, chainl1
  , chainr, chainr1
  , eof, notFollowedBy
  , many, skipMany, manyTill
  , anyToken
  )
where
import Data.Word
import MD.Parser.Parsec.Prim

infix  0 <?>
infixr 1 <|>

(<?>) :: Parser st a -> String -> Parser st a
p <?> msg = label msg p

(<|>) :: Parser st a -> Parser st a -> Parser st a
p1 <|> p2 = mplus p1 p2

choice :: [Parser st a] -> Parser st a
choice ps = msum ps

option :: a -> Parser st a -> Parser st a
option x p = p <|> return x

optional :: Parser st a -> Parser st ()
optional p = do { p; return () } <|> return ()

ignore :: Parser st a -> Parser st ()
ignore p = do { p ; return () }

between :: Parser st a -> Parser st b
        -> Parser st c -> Parser st c
between open close p = do { open; x <- p; close; return x }

skipMany1 :: Parser st a -> Parser st ()
skipMany1 p = do { p; skipMany p }

many1 :: Parser st a -> Parser st [a]
many1 p = do{ x <- p; xs <- many p; return (x:xs) }

sepBy,sepBy1 :: Parser st a -> Parser st b -> Parser st [b]
sepBy  sep p = option [] $ sepBy1 sep p
sepBy1 sep p = do { x <- p
                  ; xs <- many (sep >> p)
                  ; return (x:xs)
                  }

sepEndBy, sepEndBy1 :: Parser st a -> Parser st b -> Parser st [b]
sepEndBy  sep p = option [] $ sepEndBy1 sep p
sepEndBy1 sep p = do{ x <- p
                    ; option [x] $ do{ sep
                                     ; xs <- sepEndBy sep p
                                     ; return (x:xs)
                                     }
                    }

endBy,endBy1 :: Parser st a -> Parser st b -> Parser st [b]
endBy  sep p = many  $ do { x <- p; sep; return x }
endBy1 sep p = many1 $ do { x <- p; sep; return x }

count :: Int -> Parser st a -> Parser st [a]
count n p = sequence $ replicate n p

chainl,chainr :: Parser st a -> Parser st (a -> a -> a) -> a -> Parser st a
chainl p op x = option x $ chainl1 p op
chainr p op x = option x $ chainr1 p op

chainl1 :: Parser st a -> Parser st (a -> a -> a) -> Parser st a
chainl1 p op =
    do { x <- p; rest x }
    where
      rest x = option x $ do { f <- op
                             ; y <- p
                             ; rest (f x y)
                             }

chainr1 :: Parser st a -> Parser st (a -> a -> a) -> Parser st a
chainr1 p op =
    do { x <- p; rest x }
    where
      rest x = option x $ do { f <- op
                             ; y <- chainr1 p op
                             ; return (f x y)
                             }

anyToken :: Parser st Word8
anyToken = tokenPrim False Just

eof :: Parser st ()
eof = notFollowedBy anyToken <?> "end of input"

notFollowedBy :: Show tok => Parser st tok -> Parser st ()
notFollowedBy p = try $ option () $ do { c <- p; unexpected (show [c]) }

many :: Parser st a -> Parser st [a]
many p
  = do{ xs <- manyAccum (:) p
      ; return (reverse xs)
      }

skipMany :: Parser st a -> Parser st ()
skipMany p
  = do{ manyAccum (\_ _ -> []) p
      ; return ()
      }

manyTill :: Parser st a -> Parser st end -> Parser st [a]
manyTill p end = scan
    where
      scan = do { end; return [] } <|>
             do { x <- p; xs <- scan; return (x:xs) }
