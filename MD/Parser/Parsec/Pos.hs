{-|
  Description : Source file locations.
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Data types for tracking locations in source files.
-}
module MD.Parser.Parsec.Pos
  ( SourcePos, sourceFile, sourceLine, sourceColumn
  , sourcePos, setFilename
  , advance, advanceBytes, advanceChars
  )
where
import Data.Word

-------------------------------------------------------------------------------
-- Source Positions, file, line and column; upper left is (1,0).

data SourcePos = SP { sourceFile   :: FilePath
                    , sourceLine   :: Int
                    , sourceColumn :: Int
                    }

instance Eq SourcePos where
    SP _ l c == SP _ l' c' = l == l' && c == c'

instance Ord SourcePos where
    compare (SP _ l c) (SP _ l' c') =
        case compare l l' of
          EQ  -> compare c c'
          lgt -> lgt

instance Show SourcePos where
  show (SP f l c) = f ++ "(" ++ show l ++ "," ++ show c ++ ")"

sourcePos :: FilePath -> SourcePos
sourcePos file = SP file 1 0

setFilename :: SourcePos -> FilePath -> SourcePos
setFilename (SP _ l c) f = SP f l c

-------------------------------------------------------------------------------
-- Advance source positions for words and characters

advance :: Bool -> [Word8] -> SourcePos -> SourcePos
advance True  ws pos = advanceChars ws pos
advance False ws pos = advanceBytes (length ws) pos

advanceBytes :: Int -> SourcePos -> SourcePos
advanceBytes n (SP f l c) = SP f l (c+n)

advanceChars :: [Word8] -> SourcePos -> SourcePos
advanceChars str (SP f line col) = SP f line' col'
 where
   (line',col')    = move str line col
   move [] l c     = (l,c)
   move (w:ws) l c = case w of
     0x09 -> move ws l     (c + 8 - mod c 8)
     0x0A -> move ws (l+1)  0
     0x0D -> move ws l      c
     _    -> move ws l     (c + 1)
