#!/bin/sh

function gettime {
    if [ -f $1 ]; then
        a=`grep real $1 | sed -e 's/real.*m//'`
    else
        printf "no file"
    fi
    echo $a $2
}


f=integr.c
b=10
c=100
i=10

# clustered graph example from Derek Bruening's CGO 2005 talk
echo "=cluster;Unopt.;Verified;Unverified;Unverified -O2" > chart
echo "=table" >> chart
echo "yformat=%gs" >> chart
echo "ylabel=Total running time" >> chart
echo "xlabel=Count of 16M blocks" >> chart
echo >> chart

while [ $b -lt $c ]
do
    #echo $f - $b

    clang -DBLOCKS=$b -DFULL_UNROLL=1 -O2 $f -o $f.O2

    clang -DBLOCKS=$b -DFULL_UNROLL=1 -emit-llvm -c $f -o $f.o
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

    #sh ../../bin/stats.sh *.output

    time (./$f.exe          > /dev/null) > $f.time          2>&1
    #time (./$f.m2r.exe      > /dev/null) > $f.m2r.time      2>&1
    time (./$f.merged.exe   > /dev/null) > $f.merged.time   2>&1
    time (./$f.pipeline.exe > /dev/null) > $f.pipeline.time 2>&1
    time (./$f.O2           > /dev/null) > $f.O2.time       2>&1

    t1=`grep real $f.time          | sed -e 's/real.*m//' | sed -e 's/s//'`
    t2=`grep real $f.merged.time   | sed -e 's/real.*m//' | sed -e 's/s//'`
    t3=`grep real $f.pipeline.time | sed -e 's/real.*m//' | sed -e 's/s//'`
    t4=`grep real $f.O2.time       | sed -e 's/real.*m//' | sed -e 's/s//'`
    echo $b $t1 $t2 $t3 $t4 >> chart
    echo $b $t1 $t2 $t3 $t4

    b=`expr $b + $i`
done

perl ../../bin/bargraph.pl -pdf chart > chart.pdf
open chart.pdf

#cp -f chart     ~/src/thesis/data/aeschart.perf
#cp -f chart.pdf ~/src/thesis/data/aeschart.pdf
