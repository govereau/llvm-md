#!/bin/sh

OPTS="m2r gvn sccp licm loop-deletion dce abcd adce constprop die"

for opt in $OPTS
do
    echo $opt
    cat $opt/*.s | \
        sed -e "s/[ ]+;.*$//g" | \
        grep -v "^%"       | \
        grep -v "^declare" | \
        grep -v "^@"       | \
        grep -v "^$"       | \
        grep -v "^target"  > \
        $opt.s
done


ls -lh *.s
