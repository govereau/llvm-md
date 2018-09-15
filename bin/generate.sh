#!/bin/sh

PATH=./bin:../../../llvm/bin:$PATH

CFILE=sqlite3
echo Processing $CFILE...

###OPTS="reassociate"
OPTS="gvn sccp licm loop-deletion dce abcd adce constprop die jump-threading instcombine reassociate"

/usr/bin/clang -emit-llvm -c $CFILE.c
opt -mem2reg -f -o=m2r.o $CFILE.o

for opt in $OPTS; do
  opt -$opt -f -o=$opt.o m2r.o
done
mkdir -p m2r $OPTS

FUNCS=`llvm-nm $CFILE.o | grep "^[ ]*[tT]" | sed "s/^[ ]*[tT][ ]*//"`
for f in $FUNCS
do
    echo $f
    for opt in m2r $OPTS; do
        llvm-extract -func=$f -f -o $opt/$f.o $opt.o
        llvm-dis -f -o=$opt/$f.s $opt/$f.o
    done
done
