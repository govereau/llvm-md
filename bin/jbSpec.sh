#!/bin/bash

SPECS="sqlite3 mcf lbm libquantum bzip2 sjeng milc sphinx hmmer h264ref perlbench gcc"
OPTS="gvn sccp licm loop-deletion adce dse loop-unswitch"
RULES="phiTrim etaMu phi ldst retst ldcall ldphi cf binop"


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
    done
    rm -f *.o
}

function pipeline {
    for spec in $SPECS
    do
	echo Building pipeline for $spec
#	opt -mem2reg -f -o=$spec.m2r.o $spec.bitcode
#	llvm-dis -f -o=$spec.m2r.s $spec.m2r.o
	opt -adce -gvn -sccp -licm -loop-deletion -loop-unswitch -dse -f -o=$spec.pipeline.o $spec.m2r.o
	llvm-dis -f -o=$spec.pipeline.s $spec.pipeline.o
    done
    rm -f *.o
}

function vpipe {
    for spec in $SPECS
    do
	echo Validating $spec
	../../validate $spec.m2r.s $spec.pipeline.s +RTS -K100M > r/$spec.pipeline
    done
}

function raw {
    echo Running MD without any normalization
    
    for spec in $SPECS
    do
	echo SPEC $spec
	for opt in $OPTS
	do
	    echo Running MD for $opt
	    ../../validate $spec.m2r.s $spec.$opt.s +RTS -K100M > r/$spec.$opt
	done
    done
}

function min {
    echo Running MD without any normalization
    
    for spec in $SPECS
    do
	echo SPEC $spec
	for opt in $OPTS
	do
	    echo Running MD for $opt
	    ../../validate -none $spec.m2r.s $spec.$opt.s +RTS -K100M > r/$spec.$opt
	done
    done
}

function gvn {
    echo Running MD for GVN with various normalization packages

    GVNPACK1="-none"
    GVNPACK2="-phi"
    GVNPACK3="-phi -cf -ggep"
    GVNPACK4="-phi -cf -ggep -ldst"
    GVNPACK5="-phi -cf -ggep -ldst -etaOp -etaMu"
    GVNPACK6=""

    for spec in $SPECS
    do
        echo $spec
        echo Running MD for gvn $spec
        echo pack 1; ../../validate $GVNPACK1 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.1
        echo pack 2; ../../validate $GVNPACK2 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.2
        echo pack 3; ../../validate $GVNPACK3 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.3
        echo pack 4; ../../validate $GVNPACK4 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.4
        echo pack 5; ../../validate $GVNPACK5 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.5
        echo pack 6; ../../validate $GVNPACK6 $spec.m2r.s $spec.gvn.s +RTS -K100M > r/$spec.gvn.6
    done
}

function licm {
    for spec in $SPECS
    do
        echo Working on licm $spec
        echo pack 1; ../../validate -none $spec.m2r.s $spec.licm.s +RTS -K100M > r/$spec.licm.1
        echo pack 2;../../validate        $spec.m2r.s $spec.licm.s +RTS -K100M  > r/$spec.licm.2
    done
}

function sccp {
    echo Running MD for SCCP with various normalization packages

    for spec in $SPECS
    do
        echo Working on sccp $spec
        echo 1; ../../validate -none    $spec.m2r.s $spec.sccp.s +RTS -K100M > r/$spec.sccp.1
        echo 2; ../../validate -cf      $spec.m2r.s $spec.sccp.s +RTS -K100M > r/$spec.sccp.2
        echo 3; ../../validate -cf -phi $spec.m2r.s $spec.sccp.s +RTS -K100M > r/$spec.sccp.3
        echo 4; ../../validate          $spec.m2r.s $spec.sccp.s +RTS -K100M > r/$spec.sccp.6
    done
}
