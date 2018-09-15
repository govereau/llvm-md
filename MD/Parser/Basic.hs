{-|
  Description : Basic parser definitions and combinators.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Parser setup and basic combinators for LLVM source files.
-}
module MD.Parser.Basic
  ( module MD.Parser.Parsec
  , module MD.Parser.Basic
  )
where
import Data.List
import Control.Monad.State
import MD.Parser.Parsec hiding (label)

-------------------------------------------------------------------------------
-- Parse Warnings

type SrcLoc    = SourcePos
type Warnings  = [(SrcLoc,String)]
data PState = PState { pws :: Warnings, lblno :: Int }

type P a = Parser PState a

initState :: PState
initState = PState [] 0

setLbl :: Int -> P ()
setLbl n = modify $ \s -> s { lblno = n }

nextLbl :: P Int
nextLbl = do { s <- get
             ; let n = lblno s + 1
             ; put s { lblno = n }
             ; return n
             }

-- | Return the current source location without consuming any input.

srcloc :: P SrcLoc
srcloc = getPosition

-- | Emit a warning at the current source location.

warn :: String -> P ()
warn msg = do { loc <- srcloc ; warnAt loc msg }

-- | Emit a warning at the given source location.

warnAt :: SrcLoc -> String -> P ()
warnAt loc msg = modify $ \s -> s { pws = (loc,msg) : pws s }

-- | Return the current set of warnings

warnings :: P Warnings
warnings = liftM (reverse . pws) get

-------------------------------------------------------------------------------
-- $whitespace

comment,ws :: P ()
comment = ignore (char ';') <?> "comment"
ws      = spaces <?> "whitespace"

-- | Consumes white space and comments that are not annotations.

whiteSpace :: P ()
whiteSpace = skipMany (ws <|> (comment >> ignore line))

-- | Create a token from the given parser. This combinator will attempt to
-- parse input using the supplied parser and then consume any remaining white
-- space that follows.

token :: P a -> P a
token p = do { x <- p ; whiteSpace ; return x }

-- | Create a token parser from the given character.

symchar :: Char -> P ()
symchar = ignore . token . char

-- | Create a token parser from the given string.

symbol :: String -> P ()
symbol = ignore . token . string


-- | Complete

complete :: P a -> P a
complete p = do whiteSpace; x <- p; eof; return x

-------------------------------------------------------------------------------

-- | Parse an equals sign as a token.

equals :: P ()
equals = symchar '='

-- | Parse a semicolon as a token.

semi :: P ()
semi = symchar ';'

-- | Parse an optional set of semicolons, and emit a warning about
-- unnecessary semicolons.

optsemis :: P ()
optsemis = do { l  <- srcloc
              ; xs <- many semi
              ; when (length xs > 0) $ warnAt l "unnecessary semicolon(s)"
              }

-- | Parse one or more semicolons; warn if more than one.

semis :: P ()
semis = semi >> optsemis

-- | Parse a comma as a token.

comma :: P ()
comma = symchar ','

-- | Augment the given parser requiring braces. The braces will be parsed as
-- normal tokens.

braces :: P a -> P a
braces p = between (symchar '{') (symchar '}') p

-- | Augment the given parser requiring brackets (@[]@). The brackets will be
-- parsed as normal tokens.

brackets :: P a -> P a
brackets p = between (symchar '[') (symchar ']') p

-- | Augment the given parser requiring parentheses. The parentheses will be
-- parsed as normal tokens.

parens :: P a -> P a
parens p = between (symchar '(') (symchar ')') p

-- | Augment the given parser requiring angle brackets. The parentheses will
-- be parsed as normal tokens.

angles :: P a -> P a
angles p = between (symchar '<') (symchar '>') p

-- | Parses a sequence of zero of more items separated by semicolons. The
-- semicolons are normal tokens, and will destroy annotations (but, see
-- @semiSepAnn@ below). This parser allows any number of consecutive
-- semicolons to be used as a separator. Also, any number of semicolons may
-- appear before the first item, and the final separator (after the last
-- item) is optional.

semiSep :: P a -> P [a]
semiSep p = optsemis >> sepEndBy semis p

-- | Parse a block of semicolon separated items. This parser uses the
-- @semiSep@ parser to parse the items, bit also requires that curly braces
-- signify the beginning and end of the block.

---block :: P a -> P [a]
--block p = braces (semiSep p)

-- | Parse a tuple of items: @(a,b,...,n)@

tuple :: P a -> P [a]
tuple p = parens (sepBy comma p)

-- | Parse a list of items: @[a,b,...,n]@

--list :: P a -> P [a]
--list p = brackets (sepBy comma p)

-- | Parse a record of items : @{a,b,...,c}@

record :: P a -> P [a]
record p = braces (sepBy comma p)

-- | Parse an enumeration derived from an association list.

enumeration :: Ord a => [(a,String)] -> P a
enumeration al =
    do { x <- node (reverse $ sortBy (\x y -> compare (snd x) (snd y)) al)
       ; (spaces >> whiteSpace) <|> eof
       ; return x
       }
 where
   fst_eq (_,a:_) (_,b:_) = a == b
   fst_eq _       _       = False
   tl_snd (x,l')          = (x, tail l')

   node l'           = choice (map leaf $ groupBy fst_eq l')
   leaf []           = fail "invalid enumeration"
   leaf [(x,s)]      = string s >> return x
   leaf ((x,c:cs):l) = char   c >> node ((x,cs) : map tl_snd l)
   leaf _            = fail "invalid enumeration"
