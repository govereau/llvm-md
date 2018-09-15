#!/bin/bash

# This script evaluates the analysis success rate

#SPECS="sqlite3 bzip2 h264ref hmmer lbm libquantum mcf milc perlbench sjeng sphinx gcc"
SPECS="gcc"

function qaanalysis {
    for spec in $SPECS
    do
	awk '/^define/ {printf ("%sret void}\n",$0)}' $spec.m2r.s > $spec.dummy.s
	../../validate $spec.m2r.s $spec.dummy.s -none +RTS -k100M > r/$spec.dummy
	alarm=`grep "^ALARM" r/$spec.dummy | wc -l`
	fail=`grep "^FAIL" r/$spec.dummy | wc -l`
	succes=$[ (100 * $alarm) / ($alarm + $fail) ]
	printf "%s : %d\n" $spec $succes
    done
}

qaanalysis

