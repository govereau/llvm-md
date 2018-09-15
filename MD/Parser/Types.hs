{-|
  Description : Parsers for LLVM types.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  Parsers for LLVM types.
-}
module MD.Parser.Types
  ( type_parser, int_type )
where
import MD.Syntax.LLVM
import MD.Parser.Basic
import MD.Parser.Atoms

type_parser :: P Type
type_parser =
    do { t <- array <|> try vector <|> struct <|> pstruct <|>
              token prim <|> liftM TypeName ident
       ; post t
       }
 where
   array    = brackets (avbody Array)
   vector   = angles (avbody Vector)
   avbody f = do n <- token decimal
                 symchar 'x'
                 t <- type_parser
                 return (f n t)
   struct  = liftM Struct (record type_parser)
   pstruct = angles $ liftM PStruct (record type_parser)

post :: Type -> P Type
post t =
    do { pt <- option t (symchar '*' >> post (Pointer t))
       ; option pt $ do (ax,va) <- fun_args; post (FunTy pt va ax)
       }

fun_args :: P ([(Type,[Attr])], Bool)
fun_args = symchar '(' >> args []
 where
   args l = do { t <- type_parser
               ; p <- attrs
               ; let l' = (t,p):l
               ; choice [ symchar ',' >> args l'
                        , symchar ')' >> return (reverse l', False)
                        ]
               }
            <|>
            do { symbol "..." ; symchar ')'
               ; return (reverse l, True)
               }
            <|>
            do { symchar ')' ; return (reverse l, False) }

int_type :: P Type
int_type = char 'i' >> liftM I decimal

prim :: P Type
prim = choice
       [ int_type
       , trystr "float"     >> return F32
       , string "double"    >> return F64
       , string "fp128"     >> return F128
       , string "x86_fp80"  >> return F80
       , string "ppc_fp128" >> return F128_PPC
       , string "void"      >> return Void
       , string "label"     >> return Label
       , string "metadata"  >> return MetaData
       , string "opaque"    >> return Opaque
       ]
 where
   trystr s = try (string s)

--test s = runParser (many1 type_parser) initState (C.pack s)
