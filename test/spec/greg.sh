#!/bin/sh
OPTS="gvn sccp licm loop-deletion adce dse loop-unswitch"
CODES="sqlite3 bzip2 h264ref hmmer lbm libquantum mcf milc perlbench sjeng sphinx gcc"

function gregcsv {
    echo "program,alarm,ok,boring,fail"
    for code in $CODES
    do
        file=r/$code.pipeline
        a=`grep "^ALARM"  $file | wc -l`
        b=`grep "^BORING"  $file | wc -l`
        f=`grep "^FAIL"  $file | wc -l`
        o=`grep "^OK"   $file | wc -l`
        printf "%s,%d,%d,%d,%d\n" $code $a $o $b $f
    done
}

function gregcsv2 {
    #echo "program,alarm,ok,boring,fail"
    for file in ../shootout/*.output
    do
        code=`echo $file | sed -e 's|../shootout/||' | sed 's/.c.output//'`
        a=`grep "^ALARM"  $file | wc -l`
        b=`grep "^BORING"  $file | wc -l`
        f=`grep "^FAIL"  $file | wc -l`
        o=`grep "^OK"   $file | wc -l`
        printf "%s,%d,%d,%d,%d\n" $code $a $o $b $f
    done
}

gregcsv

gregcsv2
