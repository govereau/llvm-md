#!/bin/sh

if [ ! -e sqlite3.o ]; then
    /usr/bin/clang -emit-llvm -c sqlite3.c
fi
if [ ! -x ../../bin/runfor ]; then
    (cd ../../bin; gcc -o runfor runfor.c)
fi

#OPTS="gvn sccp licm dce loop-deletion"
#OPTS="gvn sccp licm loop-deletion dce abcd adce constprop die jump-threading instcombine reassociate"
OPTS="gvn sccp licm loop-deletion dce abcd adce constprop die"
#OPTS="jump-threading"

FUNCS=`llvm-nm sqlite3.o | grep "^[ ]*[tT]" | sed "s/^[ ]*[tT][ ]*//"`

# | grep -v pcache1TruncateUnsafe | grep -v pcache1ResizeHash | grep -v sqlite3SrcListDup | grep -v fkScanChildren | grep -v codeRowTrigger | grep -v sqlite3BtreeTripAllCursors`


rm -f results.*

for opt in $OPTS
do
    echo $opt
    ../../validate m2r.s $opt.s >> results.$opt
done
echo "\a"
