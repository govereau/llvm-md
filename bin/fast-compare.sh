#!/bin/sh

if [ -z $OPTS ]; then
    OPTS="gvn sccp licm loop-deletion dce abcd adce constprop die"
fi

rm -f results.*
for opt in $OPTS; do
    echo $opt
    ../../validate m2r.s $opt.s > results.$opt
    sh ../../bin/stats.sh results.$opt
    echo "\a"
done
