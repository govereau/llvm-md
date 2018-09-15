#!/bin/bash

SPECS="sqlite3 mcf lbm libquantum bzip2 sjeng milc sphinx hmmer h264ref perlbench gcc"
#SPECS="sqlite3 bzip2"

function pipeline {
    for spec in $SPECS
    do
        echo Building pipeline for $spec
        opt -mem2reg -f -o=$spec.m2r.o $spec.bitcode
        llvm-dis -f -o=$spec.m2r.s $spec.m2r.o
        opt -adce -gvn -sccp -licm -loop-deletion -loop-unswitch -dse -f -o=$spec.pipeline.o $spec.m2r.o
        llvm-dis -f -o=$spec.pipeline.s $spec.pipeline.o
        ../../validate pairs $spec.m2r.s $spec.pipeline.s +RTS -K100M > $spec.pipeline
    done
    rm -f *.o
}

function vpipe {
    for spec in $SPECS
    do
        echo Validating $spec
        (time ../../validate $spec.m2r.s $spec.pipeline.s +RTS -K100M >> $spec.pipeline) > $spec.time 2>&1
        cat $spec.time
    done
}

if [ "$1" = "gen" ]
then
    pipeline
fi

if [ "$1" = "run" ]
then
    vpipe
fi
