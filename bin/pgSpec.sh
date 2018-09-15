#!/bin/bash

SPECS="sqlite3 mcf lbm libquantum bzip2 sjeng milc sphinx hmmer h264ref perlbench gcc"
SPECS1="sqlite3 bzip2 perlbench gcc"
OPTS="gvn sccp licm loop-deletion adce dse loop-unswitch"

function generate {
    for spec in $SPECS
    do
        echo Building $spec files
        opt -mem2reg -f -o=$spec.m2r.o $spec.bitcode
        llvm-dis -f -o=$spec.m2r.s $spec.m2r.o
        for opt in $OPTS
        do
            echo Building $opt
            opt -$opt -f -o=$spec.$opt.o $spec.m2r.o
            llvm-dis -f -o=$spec.$opt.s $spec.$opt.o
        done
        echo building pipeline
        opt -adce -gvn -sccp -licm -loop-deletion -loop-unswitch -dse -f -o=$spec.pipeline.o $spec.m2r.o
        llvm-dis -f -o=$spec.pipeline.s $spec.pipeline.o
    done
    rm -f *.o
}

function vpipe {
    for spec in $SPECS
    do
        echo Validating $spec
        ../../validate $spec.m2r.s $spec.pipeline.s +RTS -K100M > r/$spec.pipeline &
    done
}

function vopt {
    for spec in $SPECS
    do
        echo starting $spec
        for opt in $OPTS
        do
            echo Running MD for raw $spec $opt
            ../../validate $spec.m2r.s $spec.$opt.s +RTS -K100M > r/$spec.$opt &
        done
        echo waiting for $spec
        wait
    done
}

function runpacks {
    echo Running MD for GVN with various normalization packages
    opt=$1

    PACK0="-none"
    PACK1="-phi"
    PACK2="$PACK1 -ldst"
    PACK3="$PACK2 -cf -ggep"
    PACK4="$PACK3 -etaOp -etaMu"
    PACK5=""  # everything...

    for spec in $SPECS1
    do
        echo $spec
        ../../validate $PACK0 $spec.m2r.s $spec.$opt.s +RTS -K100M > r/$spec.$opt.1 &
        ../../validate $PACK1 $spec.m2r.s $spec.$opt.s +RTS -K20M  > r/$spec.$opt.2 &
        ../../validate $PACK2 $spec.m2r.s $spec.$opt.s +RTS -K20M  > r/$spec.$opt.3 &
        ../../validate $PACK3 $spec.m2r.s $spec.$opt.s +RTS -K20M  > r/$spec.$opt.4 &
        ../../validate $PACK4 $spec.m2r.s $spec.$opt.s +RTS -K20M  > r/$spec.$opt.5 &
        ../../validate $PACK5 $spec.m2r.s $spec.$opt.s +RTS -K20M  > r/$spec.$opt.6 &
        wait
    done
}

function allpacks {
    runpacks gvn
    runpacks sccp
    runpacks licm
}
