#!/bin/sh

for f in *.c
do
    echo $f
    clang -DBLOCKS=100 -emit-llvm -c $f -o $f.o
    llvm-ld -native -o $f.exe $f.o
    llvm-dis $f.o
    opt -mem2reg -f -o $f.m2r.o $f.o
    llvm-ld -native -o $f.m2r.exe $f.m2r.o
    llvm-dis $f.m2r.o
    opt -adce -gvn -sccp -licm -loop-deletion -loop-unswitch -dse \
        -f -o $f.pipeline.o $f.m2r.o
    llvm-ld -native -o $f.pipeline.exe $f.pipeline.o
    llvm-dis $f.pipeline.o

    (time ../../validate $f.m2r.o.ll $f.pipeline.o.ll) > $f.output 2>&1
    perl ../../bin/merge.pl $f.m2r.o.ll $f.pipeline.o.ll $f.output > $f.merged.s
    llvm-as -f $f.merged.s
    llvm-ld -native -o $f.merged.exe $f.merged.s.bc

#    time (./$f.exe          > /dev/null) > $f.time          2>&1
#    time (./$f.m2r.exe      > /dev/null) > $f.m2r.time      2>&1
#    time (./$f.merged.exe   > /dev/null) > $f.merged.time   2>&1
#    time (./$f.pipeline.exe > /dev/null) > $f.pipeline.time 2>&1
done

sh ../../bin/stats.sh *.output
