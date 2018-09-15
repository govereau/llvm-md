#!/bin/sh
  
echo Compiling $1 with option $2 ...
clang $1.c -S -emit-llvm 
llvm-as -f -o=$1.o $1.s
opt -f -mem2reg $2 -o=$1.o $1.o
llvm-dis -f -o=$1$2.s $1.o
echo Done