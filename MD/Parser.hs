{-|
  Description : Parser for LLVM assembly.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Interface to the LLVM parser.
-}
module MD.Parser
  ( parseStream
  , parseFromFile
  , parseFile
  )
where
import Data.Word
import qualified Data.ByteString.Lazy as LBS
import MD.Parser.Parsec.Pos
import MD.Parser.Basic hiding (parseFile)
import MD.Parser.Module (llvmModule)

import MD.Syntax.LLVM

-------------------------------------------------------------------------------
-- Basic parsing functions

type LBS = LBS.ByteString

parseStream :: FilePath -> LBS -> Either String (Module,Warnings)
parseStream file lbs =
    case runParser p initState lbs of
      Left err    -> Left (show err)
      Right (m,w) -> Right (m,w)
 where
   p = do { pos <- getPosition
          ; setPosition (setFilename pos file)
          ; x <- llvmModule
          ; wl <- warnings
          ; return (x,wl)
          }

-- this is (clearly) a hack.

hackFile :: FilePath -> IO LBS
hackFile file =
    do { (_,ls) <- liftM (LBS.mapAccumL f 0) (LBS.readFile file)
       ; return ls
       }
 where
   f :: Word8 -> Word8 -> (Word8,Word8)
   f _ 10 = (1,10)   -- '\n'
   f 1 59 = (2,59)   -- ';'
   f 2 32 = (3,32)   -- ' '
   f 3 60 = (4,10)   -- '<' --> '\n'
   f 4 _  = (0,60)   -- _   --> '<'
   f _ x  = (0,x)

parseFromFile :: FilePath -> IO (Either String (Module,Warnings))
parseFromFile file = liftM (parseStream file) (hackFile file)

parseFile :: Bool -> FilePath -> IO Module
parseFile shw file =
    do { (m,wl) <- parseFromFile file >>= either fail return
       ; when shw $ forM_ wl print
       ; return m
       }
