#!/bin/sh
PATH=../../../llvm/bin:$PATH

# this should match generate.sh
CFILE=sqlite3
#OPTS="gvn sccp licm dce loop-deletion"
#OPTS="gvn sccp licm loop-deletion dce abcd adce constprop die jump-threading instcombine reassociate"
OPTS="instcombine"
FUNCS=`llvm-nm $CFILE.o | grep "^[ ]*[tT]" | sed "s/^[ ]*[tT][ ]*//"`

# | grep -v pcache1TruncateUnsafe | grep -v pcache1ResizeHash | grep -v sqlite3SrcListDup | grep -v fkScanChildren | grep -v codeRowTrigger | grep -v sqlite3BtreeTripAllCursors`

rm -f results.*

for f in $FUNCS
do
    echo $f
    for opt in m2r $OPTS; do
	sleep 1
        ../../validate smt m2r/$f.s $opt/$f.s +RTS -M1G >> results.$opt &
    done
done
echo "\a"