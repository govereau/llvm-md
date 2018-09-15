#!/bin/sh

function float_eval()
{
    local stat=0
    local result=0.0
    if [[ $# -gt 0 ]]; then
        result=$(echo "scale=$float_scale; $*" | bc -q 2>/dev/null)
        stat=$?
        if [[ $stat -eq 0  &&  -z "$result" ]]; then stat=1; fi
    fi
    echo $result
    return $stat
}

function barpipe {
    echo "=stacked;Validated;Alarms"
    echo "=nolegoutline"
    echo "legendfill="
    echo "=sortbmarks"
    echo "=nogridy"
    echo "=noupperright"
    echo "legendx=right"
    echo "legendy=center"
    echo "yformat=%g%%"
    echo "xlabel=Benchmarks"
    echo "ylabel=Number of functions"
    echo "=table"

#    declare -i count
    count=$(float_eval 1.0 + 0.0);
    for code in *.output
    do
        file=$code
        tag=`echo $code | sed -e 's/.c.output//'`
        a=`grep "^ALARM"  $file | wc -l`
        o=`grep "^OK"     $file | wc -l`
        e=`grep "^FAIL"   $file | wc -l`
        b=`grep "^BORING" $file | wc -l`
        t=$[ $a + $o + $b + $e ]
        printf "extraops=set label \"%d\" at %0.1f,105 right font \"Times,8\"\n" $t $count
        count=$(float_eval $count + 1.5)
    done
    for code in *.output
    do
        file=$code
        tag=`echo $code | sed -e 's/.c.output//'`
        if [ -f $file ]; then
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
            b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            bad=$[ $a + $e ]
            good=$[ $b + $o ]
            #printf "%s %3d %3d" $tag $good $bad

            v1=$[ (100 * $good) / ($bad + $good) ]
            v2=$[ (100 * $bad) / ($bad + $good) ]
            printf "%s %3d %3d" $tag $v1 $v2
        else
            printf "MISSING FILE"
        fi
        printf "\n"
    done
    printf "\n"
}

barpipe > barchart
perl ../../bin/bargraph.pl -pdf barchart > shootout.pdf
