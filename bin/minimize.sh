#!/bin/bash

SPECS="sqlite3 bzip2 h264ref hmmer lbm libquantum mcf milc perlbench sjeng sphinx"
OPTS="gvn sccp licm loop-deletion adce dse loop-unswitch instcombine reassociate" 

echo Preprocessing the bitcodes to remove boring functions

for spec in $SPECS
do
    echo $spec
    for opt in $OPTS
    do 
	echo $opt
	# Create the list of functions that matter
	../../validate compare $spec.m2r.s $spec.$opt.s > tmp
	awk '// {printf("%s ",$0)}' tmp > $spec.$opt.func
	# Create a minimized assembly code for the optimized version
	llvm-as $spec.$opt.s -o=$spec.$opt.o
	mkdir AAA$spec$opt
	for fun in `cat $spec.$opt.func`
	do
	    llvm-extract --func $fun -o $spec.$opt.$fun.o $spec.$opt.o
	    llvm-dis -o - $spec.$opt.$fun.o > AAA$spec$opt/$spec.$opt.$fun.s
	    rm $spec.$opt.$fun.o
	done
	cat AAA$spec$opt/*.s | \
            sed -e "s/[ ]+;.*$//g" | \
            grep -v "^%"       | \
            grep -v "^declare" | \
            grep -v "^@"       | \
            grep -v "^$"       | \
            grep -v "^target"  > \
            $spec.$opt.minimized.s
	rm -Rf AAA$spec$opt
	rm $spec.$opt.o
	# Create a minimized assembly code for the m2r version
	llvm-as $spec.m2r.s -o=$spec.m2r.o
	mkdir AAA$specm2r
	for fun in `cat $spec.$opt.func`
	do
	    llvm-extract --func $fun -o $spec.m2r.$fun.o $spec.m2r.o
	    llvm-dis -o - $spec.m2r.$fun.o > AAA$specm2r/$spec.m2r.$fun.s
	    rm $spec.m2r.$fun.o
	done
	cat AAA$specm2r/*.s | \
            sed -e "s/[ ]+;.*$//g" | \
            grep -v "^%"       | \
            grep -v "^declare" | \
            grep -v "^@"       | \
            grep -v "^$"       | \
            grep -v "^target"  > \
            $spec.$opt.m2r.minimized.s
	rm -Rf AAA$specm2r
	rm $spec.m2r.o
    done
done

