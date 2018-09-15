{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances #-}
{-|
  Description : Primitive parser combinators
  Copyright   : (c) Daan Leijen 1999-2001; Paul Govereau 2006-2010.
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  A modified version of the Parsec library. This version uses a lazy byte
  string as a source for parsing, and supports the @untry@ combinator.
-}
module MD.Parser.Parsec.Prim
  ( Parser
  , SourcePos(..)
  , getPosition, setPosition
  , runParser, runParser'
  , runParserIO, runParserIO'
  -- * Primitive Parsers
  , tokenPrim, tokens
  , fetch, skip, align
  , unexpected
  -- * Primitive Parser Transformers
  -- ** Moving between parser states
  , try, untry, look, onEmpty, onFail
  -- ** Augmenting error messages
  , label, labels
  -- ** Special transformers
  , manyAccum, limit, limitSkip
  , module Control.Monad
  , module Control.Monad.Writer
  , module Control.Monad.State
  )
where
import MD.Parser.Parsec.Pos
import MD.Parser.Parsec.Error
import Control.Monad
import Control.Monad.Writer (MonadWriter(..))
import Control.Monad.State  (MonadState(..))
import Data.Word
import Data.Int (Int64)
import Data.Char
import Data.List
import qualified Data.ByteString.Lazy as LBS

-------------------------------------------------------------------------------
-- The Parsing Monad

newtype Parser st a = P { runP :: State st -> ParseResult st a }

type ParseResult st a = (Result st a, ParseError)

data Result st a
   = Ok    (State st) a  -- parsing succeeded
   | Empty (State st) a  -- parser matched empty sequence
   | Failed              -- parser failed and consumed no input
   | Error               -- parsing failed - tokens consumed
   | HardError           -- parsing failed - no backtracking

type LBS = LBS.ByteString

data State st
   = State { stateInput :: LBS
           , byteOffset :: Int64
           , statePos   :: SourcePos
           , stateUser  :: st
           }

-- used internally to build results

ok :: State st -> a -> ParseResult st a
ok st x = (Ok st x, mempty)

empty :: State st -> a -> ParseResult st a
empty st x = (Empty st x, mempty)

failed :: ParseError -> ParseResult st a
failed err = (Failed, err)

perror :: ParseError -> ParseResult st a
perror err = (Error, err)

herror :: ParseError -> ParseResult st a
herror err = (HardError, err)

-------------------------------------------------------------------------------
-- Functor

instance Functor (Result st) where
    fmap f res = case res of
      Ok    st x -> Ok    st (f x)
      Empty st x -> Empty st (f x)
      Failed     -> Failed
      Error      -> Error
      HardError  -> HardError

instance Functor (Parser st) where
    fmap f p = P $ \st -> let (res,err) = runP p st in (fmap f res, err)

-------------------------------------------------------------------------------
-- Monad

instance Monad (Parser st) where
    return x = P $ \st -> empty st x
    fail msg = P $ \st -> failed (errMsg (statePos st) msg)
    p >>= f  = bind p f

bind :: Parser st a -> (a -> Parser st b) -> Parser st b
bind p f = P $ \state ->
  case runP p state of
    { (Ok st x, err) ->
          case runP (f x) st of
            (Empty st' y,err') -> (Ok st' y, mappend err err')
            (Failed     ,err') -> (Error,    mappend err err')
            other              -> other

    ; (Empty st x, err) ->
          case runP (f x) st of
            (Empty st' y,err') -> (Empty st' y, mappend err err')
            (Failed     ,err') -> (Failed,      mappend err err')
            (other      ,err') -> (other,       mappend err err')

    ; (Failed,    err) -> (Failed,    err)
    ; (Error,     err) -> (Error,     err)
    ; (HardError, err) -> (HardError, err)
    }

-- | An alternatives to fail that sets the unexpected message rather than the
-- user message.

unexpected :: String -> Parser st a
unexpected msg = P $ \st -> failed (errUnexpect (statePos st) msg)

-------------------------------------------------------------------------------
-- Monad Writer

-- pass is almost certainly useless...

instance MonadWriter ParseError (Parser st) where
    tell err = P $ \st -> (Empty st (), err)
    listen p = P $ \st -> let (res,err) = runP p st in
                          (fmap (\x -> (x,err)) res, err)
    pass   p = P $ \st -> let (res,err) = runP p st in
                          case res of
                            Ok    st' (x,f) -> (Ok    st' x, f err)
                            Empty st' (x,f) -> (Empty st' x, f err)
                            other           -> (fmap fst other,err)

-------------------------------------------------------------------------------
-- Monad Plus

instance MonadPlus (Parser st) where
    mzero = fail ""
    mplus = onFail

onFail :: Parser st a -> Parser st a -> Parser st a
onFail p1 p2 = P $ \st ->
  case runP p1 st of
    (Failed,err) -> runP (tell err >> p2) st
    other        -> other

-- | A call to @onEmpty a b@ will run parser @a@, and only run parser @b@ if
-- @a@ results in a successful but empty parse. That is, @a@ is successful
-- and did not consume any input.

onEmpty :: Parser st a -> Parser st a -> Parser st a
onEmpty p1 p2 = P $ \st ->
  case runP p1 st of
    (Empty st' _,err) -> runP (tell err >> p2) st'
    other             -> other

-------------------------------------------------------------------------------
-- Monad State

instance MonadState st (Parser st) where
    get     = liftM stateUser getState
    put usr = updateState (\st -> st { stateUser = usr })

getState :: Parser st (State st)
getState = P $ \st -> empty st st

updateState :: (State st -> State st) -> Parser st ()
updateState f = P $ \st -> empty (f st) ()

getPosition :: Parser st SourcePos
getPosition = liftM statePos getState

setPosition :: SourcePos -> Parser st ()
setPosition pos = updateState (\st -> st { statePos = pos })

-------------------------------------------------------------------------------
-- Running a parser

runParser' :: Parser st a -> st -> LBS -> Either ParseError (a,LBS)
runParser' p usr input =
  let state     = State input 0 (sourcePos "") usr
      (res,err) = runP p state
  in case res of
       Ok    st x -> seq x $ seq st $ Right (x, stateInput st)
       Empty st x -> seq x $ seq st $ Right (x, stateInput st)
       _          -> seq err        $ Left err

runParser :: Parser st a -> st -> LBS -> Either ParseError a
runParser p st input = fmap fst $ runParser' p st input

runParserIO' :: Parser st a -> st -> LBS -> IO (a,LBS)
runParserIO' p st input = either (error.show) return $ runParser' p st input

runParserIO :: Parser st a -> st -> LBS -> IO a
runParserIO p st input = liftM fst $ runParserIO' p st input

-------------------------------------------------------------------------------
-- Primitive Parsers

show' :: Bool -> [Word8] -> String
show' True  ws = map (chr . fromIntegral) ws
show' False ws = concat $ intersperse " " $ map show ws

tokenPrim :: Bool -> (Word8 -> Maybe a) -> Parser st a
tokenPrim char test = P $ \(State input off pos user) ->
   if LBS.null input then failed (errEOF pos)
   else let w  = LBS.head input
            bs = LBS.tail input
        in case test w of
             Just x  -> let pos' = advance char [w] pos
                            st   = State bs (off+1) pos' user
                        in ok st x
             Nothing -> failed (errUnexpect pos $ show' char [w])

tokens :: Bool -> [Word8] -> Parser st [Word8]
tokens char ws = P $ \state@(State input off pos user) ->
 let
   offset     = off + fromIntegral (length ws)
   error' err = errSetExpect [show' char ws] err
   eof        = error' $ errEOF pos
   unexpect w = error' $ errUnexpect pos (show' char [w])

   walk [] bs             = let pos' = advance char ws pos
                                st   = State bs offset pos' user
                            in ok st ws
   walk (x:xs) bs
       | LBS.null bs      = perror eof
       | x == LBS.head bs = walk xs (LBS.tail bs)
       | otherwise        = perror (unexpect $ LBS.head bs)

   walk1 [] _             = empty state []
   walk1 (x:xs) bs
       | LBS.null bs      = failed eof
       | x == LBS.head bs = walk xs (LBS.tail bs)
       | otherwise        = failed (unexpect $ LBS.head bs)
 in walk1 ws input


-- | Fetch a number of words from the input stream.

fetch :: Int64 -> Parser st LBS
fetch 0 = return (LBS.empty)
fetch n = P $ \(State buf off pos usr) ->
    let (b1,b2) = LBS.splitAt n buf
        pos'    = advanceBytes (fromIntegral n) pos -- underflow!!!
        off'    = off + n
    in ok (State b2 off' pos' usr) b1

-- | Skips the given number of words.

skip :: Int64 -> Parser st ()
skip n = do { fetch n; return () }

-- | Align the the given byte boundry

align :: Int64 -> Parser st ()
align n = do { offset <- liftM byteOffset getState
             ; let a = n - mod offset n
             ; skip a
             }

-------------------------------------------------------------------------------
-- Primitive Parser Transformers

try :: Parser st a -> Parser st a
try p = P $ \st ->
  case runP p st of
    (Error,     err) -> failed err --(errPos (statePos st) err)
    (HardError, err) -> perror err
    other            -> other

untry :: Parser st a -> Parser st a
untry p = P $ \st ->
  case runP p st of
    (Error,err) -> herror err
    other       -> other

look :: Parser st a -> Parser st a
look p = P $ \st ->
  case runP p st of
    (Ok    _ x, err) -> (Empty st x, err)
    (Empty _ x, err) -> (Empty st x, err)
    failure          -> failure

label :: String -> Parser st a -> Parser st a
label msg = labels [msg]

labels :: [String] -> Parser st a -> Parser st a
labels msgs p = P $ \st ->
  let (res,err) = runP p st in
  if err == mempty then (res,err) else
  case res of
    Empty _ _ -> (res, errSetExpect msgs err)
    Failed    -> (res, errSetExpect msgs err)
    _         -> (res, err)

-- | Will fail on empty.

manyAccum :: (a -> [a] -> [a]) -> Parser st a -> Parser st [a]
manyAccum accum (P p) = P $ \st ->
  case p st of
    (Failed,err) -> (Empty st [], err)
    other        -> walk [] st other
 where
   walk xs st (r,err) = case r of
     Ok st' x  -> walk (accum x xs) st' (p st')
     Empty _ _ -> error ("many of empty near:" ++ show (statePos st))
     Failed    -> ok st xs
     Error     -> perror err
     HardError -> herror err


-- | Limits the number of words that can be consumed by a parser.

limit :: Int64 -> Parser st a -> Parser st a
limit n p = P $ \st ->
  let (buf1, buf2)  = LBS.splitAt n (stateInput st)
      (res,err)     = runP p (st { stateInput = buf1 })
      fixup f st' x = let buf = LBS.append (stateInput st') buf2
                      in f (st' { stateInput = buf }) x
  in case res of
       Ok    st' x -> (fixup Ok    st' x, err)
       Empty st' x -> (fixup Empty st' x, err)
       Failed      -> (Failed           , err)
       Error       -> (Error            , err)
       HardError   -> (HardError        , err)

limitSkip :: Int64 -> Parser st a -> Parser st a
limitSkip n p =
    do { off <- liftM byteOffset getState
       ; x <- limit n p
       ; off' <- liftM byteOffset getState
       ; skip (n - (off' - off))
       ; return x
       }
