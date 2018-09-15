{-# LANGUAGE CPP, StandaloneDeriving, DeriveDataTypeable #-}
{-|
  Description : Binary instance generator.
  Copyright   : (c) Paul Govereau and Jean-Baptiste Tristan 2010
  License     : All Rights Reserved
  Maintainer  : Paul Govereau <govereau@cs.harvard.edu>

  A small program to generate Binary instances for LLVM abstract syntax.
-}
module Main where
import Data.Generics
import Data.List
import MD.Syntax.LLVM

#define LIST \
X(Opr); X(BinOp); X(CmpOp); X(FCmpOp); \
X(ConvOp); X(Linkage); X(Visibility);X(CConv);X(Attr); \
X(Ident); X(Const); \
X(Module); X(Decl); X(Argument); \
X(Type); X(Value); X(Expr); X(TV); \
X(Block); X(Label); X(Instruction); \
X(RHS); X(MemoryInst); X(ControlInst)

#define X(a) \
deriving instance Typeable a; \
deriving instance Data a

LIST

#undef X
#define X(a) putStrLn (derive (undefined::a))

main :: IO ()
main = do putStrLn "{-# OPTIONS -fno-warn-orphans #-}"
          putStrLn "module MD.Binary where"
          putStrLn "import Prelude hiding (EQ)"
          putStrLn "import Data.Binary"
          putStrLn "import MD.Syntax.Enum"
          putStrLn "import MD.Syntax.LLVM"
          putStrLn "encodeAST :: FilePath -> Module -> IO Module"
          putStrLn "encodeAST f m = do encodeFile f m; return m"
          putStrLn "decodeAST :: FilePath -> IO Module"
          putStrLn "decodeAST f = decodeFile f"
          LIST

{-
The folowing code is from the ghc-binary package; the original license terms
are included below.

Copyright (c) Lennart Kolmodin

All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

3. Neither the name of the author nor the names of his contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY EXPRESS
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
-}

derive :: (Typeable a, Data a) => a -> String
derive x =
    "instance " ++ context ++ "Binary " ++ inst ++ " where\n" ++
    concat putDefs ++ getDefs
    where
    context
        | nTypeChildren > 0 =
            wrap (join ", " (map ("Binary "++) typeLetters)) ++ " => "
        | otherwise = ""
    inst = wrap $ tyConString typeName ++ concatMap (" "++) typeLetters
    wrap x = if nTypeChildren > 0 then "("++x++")" else x
    join sep lst = concat $ intersperse sep lst
    nTypeChildren = length typeChildren
    typeLetters = take nTypeChildren manyLetters
    manyLetters = map (:[]) ['a'..'z']
    (typeName,typeChildren) = splitTyConApp (typeOf x)
    constrs :: [(Int, (String, Int))]
    constrs = zip [0..] $ map gen $ dataTypeConstrs (dataTypeOf x)
    gen con = ( showConstr con
              , length $ gmapQ undefined $ fromConstr con `asTypeOf` x
              )
    putDefs = map ((++"\n") . putDef) constrs
    putDef (n, (name, ps)) =
        let wrap = if ps /= 0 then ("("++) . (++")") else id
            pattern = name ++ concatMap (' ':) (take ps manyLetters)
        in
        "  put " ++ wrap pattern ++" = "
        ++ concat [ "putWord8 " ++ show n | length constrs  > 1 ]
        ++ concat [ " >> "                | length constrs  > 1 && ps  > 0 ]
        ++ concat [ "return ()"           | length constrs == 1 && ps == 0 ]
        ++ join " >> " (map ("put "++) (take ps manyLetters))
    getDefs =
       (if length constrs > 1
        then "  get = do\n    tag_ <- getWord8\n    case tag_ of\n"
        else "  get =")
        ++ concatMap ((++"\n")) (map getDef constrs) ++
       (if length constrs > 1
        then "      _ -> fail \"no parse\""
        else ""
       )
    getDef (n, (name, ps)) =
        let wrap = if ps /= 0 then ("("++) . (++")") else id
        in
        concat [ "      " ++ show n ++ " ->" | length constrs > 1 ]
        ++ concatMap (\x -> " get >>= \\"++x++" ->") (take ps manyLetters)
        ++ " return "
        ++ wrap (name ++ concatMap (" "++) (take ps manyLetters))
