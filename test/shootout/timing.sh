#!/bin/sh

function gettime {
    if [ -f $1 ]; then
        a=`grep real $1 | sed -e 's/real.*m//'`
    else
        printf "no file"
    fi
    echo $a $2
}

echo '\begin{tabular}{llll}'
echo 'Benchmark & Unoptimized & Verified & Unverified \\\\'
echo '\\hline'

for f in *.c
do
    echo "$f &"
    gettime $f.time "&"
#    gettime $f.m2r.time "&"
    gettime $f.merged.time "&"
    gettime $f.pipeline.time '\\\\'
done

echo '\end{tabular}'
