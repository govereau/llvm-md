#!/bin/sh

f=$1
if [ -z $f ]; then
    echo "stats.sh <result-file> [<result-file> ...]"
    exit 1
fi

declare -i a b o e t
printf "=========================== Boring   OK       Alarm    Fail     Total\n"
until [ -z "$1" ]  # Until all parameters used up . . .
do
    f=$1
    if [ -f $f ]; then
        b=`grep "^BORING" $f | wc -l`
        o=`grep "^OK"     $f | wc -l`
        a=`grep "^ALARM"  $f | wc -l`
        e=`grep "^FAIL"   $f | wc -l`
        t=$[$a + $b + $e + $o]
        printf "%-27s %-9d%-9d%-9d%-9d%-9d\n" $f $b $o $a $e $t
    else
        echo "$f does not exist"
    fi
    shift
done
