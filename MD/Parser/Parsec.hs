{-|
  Description : Modified Parsec library.
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  A modified version of the Parsec library. This version uses a lazy byte
  string as input, and has some basic support for parsing binary streams.
-}
module MD.Parser.Parsec
  ( ParseError
  , module MD.Parser.Parsec.Prim
  , module MD.Parser.Parsec.Combinator
  , module MD.Parser.Parsec.Char
  , parseFile
  , parseLBS
  )
where
import MD.Parser.Parsec.Error          -- parse errors
import MD.Parser.Parsec.Prim           -- primitive combinators
import MD.Parser.Parsec.Combinator     -- derived combinators
import MD.Parser.Parsec.Char           -- character parsers

import qualified Data.ByteString as SBS
import qualified Data.ByteString.Lazy as LBS

parseFile :: Parser () a -> FilePath -> IO a
parseFile p file =
    do { bs <- SBS.readFile file
       ; runParserIO p () (LBS.fromChunks [bs])
       }

parseLBS :: Parser () a -> LBS.ByteString -> IO a
parseLBS p lbs = runParserIO p () lbs
