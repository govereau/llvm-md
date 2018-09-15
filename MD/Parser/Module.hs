{-|
  Description : LLVM module parser.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Parser for assembly files: each file contains one LLVM module.
-}
module MD.Parser.Module ( llvmModule ) where
import Prelude hiding (const)
--import Data.Char (digitToInt)
import MD.Syntax.LLVM
import MD.Parser.Basic
import MD.Parser.Atoms
import MD.Parser.Types

-------------------------------------------------------------------------------
-- | Parse a complete LLVM module file.

llvmModule :: P Module
llvmModule = liftM Module (complete (many decl))

decl, target, global, declare, typedef, define :: P Decl
decl = choice [ try target, global, try declare
              , typedef' (Ident "?")
              , typedef, define
              ]

target  = do { symbol "target" ; token line; return Target  }
declare = do { symbol "declare"; token line; return Declare }

global =
    do { char '@' --look (char '@')
       ; token line
       ; --i <- ident
       ; --equals
       ; --optional (symbol "internal" <|> symbol "private")
       ; --symbol "constant" <|> symbol "global"
       ; --ty  <- type_parser
       ; --val <- value
       ; return $ Global (Ident "") (I 0) (Const (Int 0))
       }

typedef = do { i <- ident
             ; equals
             ; typedef' i
             }

typedef' :: Ident -> P Decl
typedef' i = do { symbol "type"
                ; t <- type_parser
                ; return (TypeDef i t)
                }

define =
    do { symbol "define"
       ; f <- liftM4 Function linkage visibility cconv attrs
       ; rty <- type_parser
       ; n <- globalId
       ; args <- tuple (argument <|> dots)
       ; -- maybe we need these attrtbutes ?
       ; manyTill anyChar (char '{')
       ; whiteSpace
       ; bs <- blocks
       ; symchar '}'
       ; return (f rty n args bs)
       }
 where
   dots = symbol "..." >> return Dots
   argument = do { at <- type_parser
                 ; al <- attrs
                 ; an <- option (Ident "?") ident
                 ; return $ Arg at al an
                 }

blocks :: P [Block]
blocks = do { setLbl (100000) ; many block }
 where
   block :: P Block
   block = do { bf <- li <|> try ls <|> ln
              ; xs <- many ins
              ; ci <- term_ins
              ; return (bf xs ci)
              }
   li = do { string "<abel>:"
           ; n <- liftM fromInteger (token nat)
           ; --setLbl n
           ; return (Block (show n) n)
           }
   ls = do { n <- label
           ; x <- nextLbl
           ; return (Block n x)
           }
   ln = do { --n <- nextLbl
           ; return (Block "0" 0)
           }

--- VALUES ---

const :: P Const
const = num <|>
        (symbol "undef" >> return Undef) <|>
        (symbol "null" >> return Null) <|>
        (symbol "false" >> return (Int 0)) <|>
        (symbol "true" >> return (Int 1))

value :: P Value
value = try (liftM Var ident) <|> try (liftM Const const) <|> gep <|> cop <|> convV

cop :: P Value
cop = do { bop <- enumeration binop_map
         ; symchar '('
         ; t1 <- type_parser
         ; l <- value
         ; comma
         ; t2 <- type_parser
         ; r <- value
         ; symchar ')'
         ; when (t1 /= t2) $ fail "invalid bin op"
         ; return $ ConstExpr $ BinOp (Bop bop) "" t1 l r
         }


convV :: P Value
convV = conv' ConstExpr parens

conv :: P RHS
conv = conv' Expr id

conv' :: (Expr -> a) -> (P a -> P a) -> P a
conv' c trans =
    do { op <- enumeration convop_map
       ; trans $ do { t1 <- type_parser
                    ; v <- value
                    ; symbol "to"
                    ; t <- type_parser
                    ; return (c $ Conv op (TV t1 v) t)
                    }
       }

num :: P Const
num = token (try k <|> start)
 where
   k     = do { string "0xK"
              ; cs <- many1 hexDigit
              ; return $ Float cs --cvtToDbl (foldl (\x d -> 16*x + toInteger (digitToInt d)) 0 cs)
              }
   start = do { i <- int; option (Int i) (dbl i) }
   dbl i = do { char '.'
              ; n <- nat
              ; let d = divs (fromInteger n) :: Double
              ; let f = fromInteger i + d
              ; e <- option 0 (char 'e' >> int)
              ; let fm = 10.0 ^^ e
              ; return (Float $ show (f * fm))
              }
   divs x | x < 1.0   = x
          | otherwise = divs (x / 10)

gep :: P Value
gep = do { symbol "getelementptr"
         ; optional (try $ symbol "inbounds")
         ; symchar '('
         ; tv1 <- tv
         ; tvs <- many (comma >> tv)
         ; symchar ')'
         ; return $ ConstExpr $ GetElemPtr tv1 tvs
         }
 where
   tv = liftM2 TV type_parser value

gep2 :: P RHS
gep2 = do { symbol "getelementptr"
          ; optional (try $ symbol "inbounds")
          ; --symchar '('
          ; tv1 <- tv
          ; tvs <- many (comma >> tv)
          ; --symchar ')'
          ; return $ Expr $ GetElemPtr tv1 tvs
         }
    where
   tv = liftM2 TV type_parser value


--- CONTROL FLOW ---

term_ins :: P ControlInst
term_ins = choice [ ret, unreachable, br, switch ] <?> "control instruction"
 --, switch, indirectbr, invoke, unwind, unreachable ]

ret,unreachable,br,switch :: P ControlInst
--indirectbr,invoke,unwind,unreachable
--indirectbr  = return (Unknown "")
--invoke      = return (Unknown "")
--unwind      = return (Unknown "")
--unreachable = return (Unknown "")

ret = do { symbol "ret"
         ; t <- type_parser
         ; case t of
             Void -> return (Return Nothing)
             _    -> do v <- value ; return (Return (Just $ TV t v))
         }

unreachable = do { symbol "unreachable"; return Unreachable }

switch = do { symbol "switch"
            ; (tv,l) <- tvl
            ; arms <- brackets (many tvl)
            ; return (Switch tv l arms)
            }
 where
   tvl = do { t <- token int_type
            ; v <- value
            ; comma; symbol "label"
            ; l <- labelId
            ; return (TV t v,l)
            }

br  = do { symbol "br"
         ; choice [ symbol "label" >> jmp
                  , symbol "i1"    >> cbr ]
         }
 where
   jmp = do n <- labelId; return (Br n)
   cbr = do { v <- value
            ; comma ; symbol "label"
            ; l1 <- labelId
            ; comma ; symbol "label"
            ; l2 <- labelId
            ; return (CBr v l1 l2)
            }


--- Expressions ---

memory :: P MemoryInst
memory = choice [ alloc, malloc, free, ldst ]
 where
   alloc  = do { symbol "alloca"
               ; t <- type_parser
               ; n <- option (Const (Int 1)) $ try $
                 do { comma
                    ; (try (symbol "i32") <|> symbol "i64")
                    ; value
                    }
               ; a <- option 0       (do comma; symbol "align"; token nat)
               ; return $ Alloca t n a
               }
   malloc = do { symbol "malloc"
               ; t <- type_parser
               ; comma
               ; vt <- type_parser
               ; v <- value
               ; return $ Malloc t (TV vt v)
               }
   free   = do { symbol "free"
               ; t <- type_parser
               ; v <- value
               ; return $ Free (TV t v)
               }
   ldst   = do { b <- option False (symbol "volatile" >> return True)
               ; load b <|> stor b
               }
   load b = do { symbol "load"
               ; t <- type_parser
               ; v <- value
               ; optional (comma >> symbol "align" >> token nat)
               ; return $ Load b (TV t v)
               }
   stor b = do { symbol "store"
               ; t <- type_parser
               ; v <- value
               ; comma
               ; pt <- type_parser
               ; p <- value
               ; unless (pt == Pointer t) $ fail "mismatched type in store"
               ; optional (comma >> symbol "align" >> token nat)
               ; return $ Store b (TV t v) p
               }

arith :: P RHS
arith = do { bop <- enumeration binop_map
           ; s <- case bop of
                    Add  -> nostuff
                    Sub  -> nostuff
                    Mul  -> nostuff
                    SDiv -> exact
                    _    -> return []
           ; ty <- type_parser
           ; v1 <- value ; comma
           ; v2 <- value
           ; return $ Expr $ BinOp (Bop bop) s ty v1 v2
           }
 where
   osym s  = option [] (try (symbol s) >> return s)
   exact   = osym "exact"
   nostuff = liftM2 (++) (osym "nuw") (osym "nsw")


ins :: P Instruction
ins = do { bid <- option Nothing (do x <- ident; equals; return (Just x))
         ; rhs <- choice [ call
                         , try memop
                         , phi
                         , try icmp
                         , try fcmp
                         , try arith
                         , try conv
                         , gep2
                         , try select
                         , extract
                         ]
         ; return (Instruction bid rhs)
         }
 where
   memop = do { mi <- memory ; return (MemOp mi) }
   phi   = do { try (symbol "phi")
              ; t <- type_parser
              ; v1 <- vl
              ; vs <- many (comma >> vl)
              ; return $ Phi t (v1 : vs)
              }
   vl    = brackets (do v <- value; comma; l <- labelId; return (v,l))
   call  = do { try $ optional (symbol "tail")
              ; symbol "call"
              ; optional (try $ symbol "fastcc")
              ; _ <- attrs
              ; _ <- type_parser
              ; v <- value
              ; ax <- tuple arg
              ; optional $ many ( do { char 'n'; char 'o'
                                     ; symbol "unwind" <|> symbol "return"
                                     }
                                  <|> (try $ symbol "readnone"))
              ; return (Call v ax)
              }
   arg   = do { t <- type_parser
              ; _ <- attrs
              ; v <- value
              ; return (TV t v)
              }
--   unk = token line >> return (Unknown "")

select :: P RHS
select = do { symbol "select"
            ; cn <- tv ; comma
            ; v1 <- tv ; comma
            ; v2 <- tv
            ; return (Expr $ Select cn v1 v2)
            }
 where
   tv = liftM2 TV type_parser value

extract :: P RHS
extract = do { symbol "extractvalue"
             ; tv <- liftM2 TV type_parser value
             ; xs <- many1 (comma >> token nat)
             ; return (Expr $ Extract tv xs)
             }

icmp :: P RHS
icmp = do { symbol "icmp"
          ; op <- enumeration cmpop_map
          ; ty <- type_parser
          ; v1 <- value ; comma
          ; v2 <- value
          ; return (Expr $ BinOp (Cmp op) "" ty v1 v2)
          }

fcmp :: P RHS
fcmp = do { symbol "fcmp"
          ; op <- enumeration fcmpop_map
          ; ty <- type_parser
          ; v1 <- value ; comma
          ; v2 <- value
          ; return (Expr $ BinOp (FCmp op) "" ty v1 v2)
          }
