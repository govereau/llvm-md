{-|
  Description : Parser errors.
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Parser errors with source positions.
-}
module MD.Parser.Parsec.Error
  ( ParseError
  , errMsg
  , errUnexpect
  , errEOF
  , errPos
  , errSetExpect
  , module Data.Monoid
  )
where
import MD.Parser.Parsec.Pos
import Data.Monoid
import Data.List (intersperse,nub,sort)

-------------------------------------------------------------------------------
-- Parse Errors

data ParseError
   = Ok
   | PE { pos  :: SourcePos  -- source position
        , ex   :: [String]   -- expected
        , unex :: String     -- unexpected
        , user :: String     -- user message
        } deriving Eq

instance Monoid ParseError where
    mempty        = Ok --PE (sourcePos "") [] "" "Ok"
    mappend Ok e2 = e2
    mappend e1 Ok = e1
    mappend e1 e2 = if pos e1 > pos e2
                    then e1 { ex = ex e1 ++ ex e2 }
                    else e2 { ex = ex e2 ++ ex e1 }

-------------------------------------------------------------------------------
-- Creating parse errors

errMsg :: SourcePos -> String -> ParseError
errMsg p m = PE p [] "" m

errUnexpect :: SourcePos -> String -> ParseError
errUnexpect p m = PE p [] m ""

errEOF :: SourcePos -> ParseError
errEOF p = errUnexpect p "<end of file>"

errPos :: SourcePos -> ParseError -> ParseError
errPos p err = err { pos = p }

errSetExpect :: [String] -> ParseError -> ParseError
errSetExpect es err = err { ex = es }

-------------------------------------------------------------------------------
-- Displaying Parse Errors

instance Show ParseError where show = showError

showError :: ParseError -> String
showError err = show (pos err) ++ ":" ++ msg
 where
   epc = concat $ intersperse ", " $ reverse $ sort $ nub $ ex err
   une = unex err
   usr = user err
   msg | null usr  = '\n':basic
       | otherwise = usr
   basic = "  unexpected : \"" ++ une ++ "\"\n" ++
           "  expected   : " ++ epc
