#!/bin/sh

for f in result*
do
    echo $f
    sh ../../bin/stats.sh $f
done
