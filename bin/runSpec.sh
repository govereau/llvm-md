#!/bin/sh

rm -f *.s *.o

# astar bzip2 dealII gcc gobmk h264ref hmmer lbm libquantum mcf milc namd
# omnetpp perlbench povray sjeng soplex specrand sphinx_livepretend

# works: specrand mcf lbm libquantum astar bzip2 sjeng milc sphinx hmmer
#        h264ref perlbench

# doesn't work:
# namd    - uses invoke/unwind
# soplex  - uses invoke/unwind
# omnetpp - uses invoke/unwind
# povray  - uses invoke/unwind
# dealII  - uses invoke/unwind

# memory error: gobmk gcc

SPECS="specrand mcf lbm libquantum astar bzip2 sjeng milc sphinx hmmer h264ref perlbench"

for spec in $SPECS
#bzip2 lbm mcf milc specrand
do
echo SPEC $spec

echo building m2r
opt -mem2reg -f -o=m2r.o $spec.bitcode
llvm-dis -f -o=m2r.s m2r.o

for opt in gvn sccp licm loop-deletion dce adce constprop die
do
    echo building $opt
    opt -$opt -f -o=$opt.o m2r.o
    llvm-dis -f -o=$opt.s $opt.o
    echo Running MD for $opt
    ../../validate m2r.s $opt.s +RTS -K20M > r.$spec.$opt
done
sh ../../bin/stats.sh r.$spec.*

done

sh ../../bin/stats.sh r.*
