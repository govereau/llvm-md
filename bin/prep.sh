#!/bin/bash

OPTS="gvn sccp licm loop-deletion adce dse loop-unswitch"
CODES="sqlite3 bzip2 h264ref hmmer lbm libquantum mcf milc perlbench sjeng sphinx gcc"
DST="/Users/jean-baptistetristan/Documents/POPL11/PLDI/data"

function header {
printf "\\\\documentclass[]{slides} \n"
printf "\\\\usepackage[pdftex]{graphicx}"
printf "\\\\begin{document} \n"
printf "\\\\scalebox{0.3}{ \n"
printf "\\\\begin{tabular}{|l||"
for i in $1
do
    printf "c|"
done
printf "} \n"
printf " \\hline \n"
for i in $2
do
    printf " & %s" $i
done
printf "\\\\\\\\ \n"
printf " \\hline \n"
printf " \\hline \n"    
}

function footer {
printf "\\\\end{tabular} \n } \n"
printf "\\\\end{document} \n"
}

function rawdata {
header "1 2 3 4 5 6 7 8 9 10" "$OPTS"
for code in $CODES
do
    printf "%20s" $code
    for opt in $OPTS
    do
	file=r/$code.$opt
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    tot=$[$o + $a]
	    if [ $tot == "0" ]; then
		printf " & irr"
	    else
		t=$[(100 * $o) / $tot]
		time=`awk '/user/ {print $2}' r/$code.$opt.time | sed -e s/m/\ / -e s/s/\ / | awk '// {print ($1 * 50 + $2)}'`
		printf " & \\\\begin{tabular}{c} %d \\\\\\\\ (%d) \\\\\\\\ %s  \\\\end{tabular}" $t $tot $time  
	    fi
	else
	    printf " & nof"
	fi    
    done
    printf "\\\\\\\\ \n \\hline \n"
done
printf "\\hline \n"
printf "%20s" "total"
declare -i overallOK
declare -i overallALARM
declare -f overallTime
for opt in $OPTS
do
    overallOK=0;
    overallALARM=0;
    overallTime=0;
    for code in $CODES
    do
	file=r/$code.$opt
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    overallOK=$[$overallOK + $o]
	    overallALARM=$[$overallALARM + $a]
	    #time=`awk '/user/ {print $2}' r/$code.$opt.time | sed -e s/m/\ / -e s/s/\ / | awk '// {print ($1 * 50 + $2)}'`
	    #echo $time
	    #arf=$[ $o + $a ]
	    #if [ $arf <> "0" ]; then
		#overalltime=$[ $overallTime + $time]
	    #fi
	fi
    done
    tott=$[ $overallOK + $overallALARM]
    tt=$[(100 * $overallOK) / $tott]
    printf " & \\\\begin{tabular}{c} %d \\\\\\\\ (%d) \\\\\\\\ %d \\\\end{tabular}" $tt $tott 0
done
printf "\\\\\\\\ \n \\hline\n"  
footer
}

function rawgraph {
declare -i overOK
declare -i overALARM
printf "=cluster"
for code in $CODES
do
    printf ";%s" $code
done
printf "\n=patterns \n=table \n"
echo "yformat=%g%%" 
printf "max=100 \n=norotate \n"
printf "ylabel=Percentage of validated optimizations \n"
printf "extraops=set 1.2,1\n"
for opt in $OPTS
do
    overOK=0
    overALARM=0
    printf "%20s" $opt
    for code in $CODES
    do
	file=r/$code.$opt
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    overOK=$[ $overOK + $o ]
	    overALARM=$[ $overALARM + $a ]
	    tot=$[$o + $a]
	    if [ $tot == "0" ]; then
		printf " 100"
	    else
		t=$[(100 * $o) / $tot]
		printf " %3d" $t
	    fi
	else
	    printf "MISSING FILE"
	fi    
    done
    t=$[(100 * $overOK) / ($overOK + $overALARM)]
    printf " %3d" $t
    printf "\n"
done
printf "\n" 
}

OPTS1="sccp licm loop-deletion dse loop-unswitch"
OPTS2="gvn instcombine"
OPTS3="adce reassociate"

function rawgraph2 {
echo "=stackcluster;Validated;Alarms"
echo "=sortbmarks"
echo "=nogridy"
echo "=noupperright"
echo "legendx=right"
echo "legendy=center"
echo "yformat=%g"
echo "xlabel=Optimizations x benchmarks"
echo "ylabel=Number of functions"
declare -i overOK
declare -i overALARM
echo "=table"
for opt in $1
do
    overOK=0
    overALARM=0
    printf "multimulti=%s\n" $opt
    for code in $CODES
    do
	file=r/$code.$opt
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    overOK=$[ $overOK + $o ]
	    overALARM=$[ $overALARM + $a ]
	    tot=$[$o + $a]
	    printf "%s %3d %3d" $code $o $a 
	else
	    printf "MISSING FILE"
	fi   
	printf "\n"
    done
done
printf "\n"
}

function rawgraphinverted {
echo "=stackcluster;Validated;Alarms"
echo "=sortbmarks"
echo "=nogridy"
echo "=noupperright"
echo "legendx=right"
echo "legendy=center"
echo "yformat=%g"
echo "xlabel=Optimizations"
echo "ylabel=Number of optimized functions"
declare -i overOK
declare -i overALARM
echo "=table"
for code in $1
do
    printf "multimulti=%s\n" $code
    for opt in $OPTS
    do
	file=r/$code.$opt
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    printf "%s %3d %3d" $opt $o $a 
	else
	    echo MISSING FILE $file 
	fi   
	printf "\n"
    done
done
printf "\n"
}

function norm {
header "$1" "$1"
for code in $CODES
do
    printf "%s" $code    
    for num in $1
    do
	file=r/$code.$2.$num
	if [ -f $file ]; then 
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
	    tot=$[$o + $a]
	    if [ $tot == "0" ]; then
		printf " & irr"
	    else 
            t=$[(100 * $o) / $tot]		
	    printf " & %d" $t
	    fi
	else
	    printf " & nof"
	fi    
    done
    printf "\\\\\\\\ \n"
    printf "\\hline \n"

done
printf "\\hline \n"
printf "%20s" "total"
declare -i overallOK
declare -i overallALARM
for num in $1
do
    overallOK=0;
    overallALARM=0;
    for code in $CODES
    do
	file=r/$code.$2.$num
	if [ -f $file ]; then 
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
	    overallOK=$[$overallOK + $o]
	    overallALARM=$[$overallALARM + $a]
	fi
    done
    tott=$[ $overallOK + $overallALARM]
    tt=$[(100 * $overallOK) / $tott]
    printf " & %d" $tt
done
printf "\\\\\\\\ \n \\hline\n"  
footer
}

function normgraph {
printf "=stacked"
for num in $1 
do
    printf ";%s" $num
done
printf "\n"
echo "column=last"
echo "max=100"
#echo "=arithmean"
echo "=sortbmarks"
echo "=nogridy"
echo "=noupperright"
echo "legendx=right"
echo "legendy=center"
echo "=nolegoutline"
echo "legendfill="
echo "yformat=%g%%"
echo "xlabel=Benchmark"
echo "ylabel=Percentagle of success"
prevAbs=(0 0 0 0 0 0 0 0 0 0 0 0)
prevPer=(0 0 0 0 0 0 0 0 0 0 0 0)
declare -i index
    for num in $1
    do
	if [ $num == "1" ]; then
	    printf "\n"
	else
	    printf "=multi\n"
	fi
	index=0;
	for code in $CODES
	do
	    file=r/$code.$2.$num
	    if [ -f $file ]; then 
		o=`grep "^OK"     $file | wc -l`
		a=`grep "^ALARM"  $file | wc -l`
	    else
		echo "MISSING FILE"
	    fi
	    newOk=$[ $o - ${prevAbs[$index]} ]
	    total=$[ $o + $a ]
	    if [ $total != "0" ]; then
		per=$[ (100 * $o) / $total ]
		newPer=$[ $per - ${prevPer[$index]} ]  
		printf "%10s %3s: %3d => %3.3f" $code $num $newOk $newPer
		echo %
	    fi
	    prevAbs[$index]=$o
	    prevPer[$index]=$per
	    index=$[ $index + 1 ]
	done
    done
}

function pdf {
echo Producing the pdf
pdflatex $1.tex
echo Opening the pdf 
open $1.pdf &
}

function data {

echo Generating the latex source for raw results
raw > tmp.tex 
echo Replacing a few keywords
sed -e s/instcombine/ic/ -e s/reassociate/rea/ -e s/loop-deletion/ld/ -e s/loop-unswitch/lu/< tmp.tex > $1.tex
pdf $1

echo Generating the latex source for GVN normalization
#norm "1 2 3 4 5 6 7 8 9" gvn > $1.gvn.tex
norm "1 2 3 4 5" gvn > $1.gvn.tex
pdf $1.gvn

echo Generating the latex source for LICM normalization
norm "1 2" licm > $1.licm.tex
pdf $1.licm

echo Generating the latex source for SCCP normalization
norm "1 2 3 4 5 6" sccp > $1.sccp.tex
pdf $1.sccp
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
    echo "yformat=%g"
    echo "xlabel=Benchmarks"
    echo "ylabel=Number of functions"
    echo "=table"
    for code in $CODES
    do
	file=r/$code.pipeline
	if [ -f $file ]; then 
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
            b=`grep "^BORING"  $file | wc -l`
            o=`grep "^OK"   $file | wc -l`	
            t=$[ $a + $e + $b + $o ];
	    bad=$[ $a + $e ]
	    good=$[ $t - $bad ]
	    printf "%s %3d %3d" $code $good $bad 
	else
	    printf "MISSING FILE"
	fi   
	printf "\n"
    done
    printf "\n"
}

function greg {
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
    echo "ylabel=Number of optimized functions"
    echo "=table"
#    declare -i count
    count="1.7";
    for code in $CODES
    do
        file=r/$code.pipeline
        a=`grep "^ALARM"  $file | wc -l`
        b=`grep "^BORING"  $file | wc -l`
        f=`grep "^FAIL"  $file | wc -l`
        o=`grep "^OK"   $file | wc -l`

        bad=$[ $a ]
        good=$[ $o + $b ]
        t=$[ $good + $bad ]


        v1=$[ (100 * $good) / ($bad + $good) ]
        v2=$[ (100 * $bad) / ($bad + $good) ]
        printf "%s %3d %3d\n" $code $v1 $v2
        printf "extraops=set label \"%d\" at %0.2f,105 right font \"Times,9\"\n" $t $count
        count=`echo "$count + 1.5" | bc -q`
    done

    for code in $CODES
    do
	file=r/$code.pipeline
	if [ -f $file ]; then
            a=`grep "^ALARM"  $file | wc -l`
            b=`grep "^BORING"   $file | wc -l`
            f=`grep "^FAIL"   $file | wc -l`
            o=`grep "^OK"   $file | wc -l`
	    bad=$[ $a ]
	    good=$[ $o + $b ]
	    v1=$[ (100 * $good) / ($bad + $good) ]
	    v2=$[ (100 * $bad) / ($bad + $good) ]
	    #printf "%s %3d %3d" $code $v1 $v2 
	else
	    printf "MISSING FILE\n"
	fi
    done
    printf "\n"
}


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


function pipepip {
declare -i overallA
declare -i overallF
declare -i overallT
overallA=0;
overallF=0;
overallT=0;
    for code in $CODES
    do
	file=r/$code.pipeline
	if [ -f $file ]; then 
	    b=`grep "^BORING" $file | wc -l`
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
            e=`grep "^FAIL"   $file | wc -l`
	    total=$[ $o + $b +$a + $e ]
	    alrate=$[ 100 * $a / $total ]
	    farate=$[ 100 * $e / $total ]
            opt=$[ $a + $o ]
            success=$[ 100 * $o / $opt ]
            sum=$[ $alrate + $farate ]
	    overallA=$[ $overallA + $a]
	    overallF=$[ $overallF + $e]
	    overallT=$[ $overallT + $total]
	    printf "%s %3d %3d %3d %3d" $file $alrate $farate $sum $success 
	else
	    printf "MISSING FILE"
	fi   
	printf "\n"
    done
    oalrate=$[ 100 * $overallA / $overallT ]
    ofarate=$[ 100 * $overallF / $overallT ]
    tsum=$[ $oalrate + $ofarate ]
    printf "Total %3d %3d %3d" $oalrate $ofarate $tsum  
    printf "\n"
}

function prodpipe {
    barpipe > data.pipeline
    ../../bin/bargraph.pl -pdf data.pipeline > data.pipeline.pdf
}

function prodgreg {
    greg > data.greg
    rm greg.pdf
    ../../bin/bargraph.pl -pdf data.greg > greg.pdf
}

function pipetime {
    printf "\\\\begin{tabular}{|l|"
    for spec in $CODES
    do
	printf "c|"
    done
    printf "}\n"
    printf "Benchmark"
    for spec in $CODES
    do
	printf " & %10s" $spec
    done
    printf "\\\\\\\\ \n"
    printf "Time"
    for spec in $CODES
    do
	file=r/$spec.pipeline.time
	if [ -f $file ]; then
	    time=`awk '/user/ {print $2}' r/$spec.pipeline.time | sed -e s/m/\ / -e s/s/\ / | awk '// {print ($1 * 60 + $2)}'`
	    printf " & %3.3f" $time
	else
	    echo MISSING FILE
	fi
    done
    printf "\\\\\\\\ \n \\\\end{tabular} \n"
    printf "\n"    
}

function theresult {
    declare -i overallOK
    declare -i overallALARM
    overallOK=0;
    overallALARM=0;
    for code in $CODES
    do
	file=r/$code.pipeline
	if [ -f $file ]; then
            o=`grep "^OK"     $file | wc -l`
            a=`grep "^ALARM"  $file | wc -l`
	    overallOK=$[ $overallOK + $o ]
	    overallALARM=$[ $overallALARM + $a ]
	else
	    echo MISSING FILE
	fi
    done
    total=$[ $overallOK + $overallALARM  ]
    res=$[ (100 * $overallOK) / $total ]
    echo We validate $res% of the $total optimized functions 
}

function produce {
    rawgraph2 "$OPTS1" > data1
    rawgraph2 "$OPTS2" > data2
    rawgraph2 "$OPTS3" > data3
    ../../bin/bargraph.pl -pdf data1 > data1.pdf
    ../../bin/bargraph.pl -pdf data2 > data2.pdf
    ../../bin/bargraph.pl -pdf data3 > data3.pdf
}

function produceinverse {
   rawgraphinverted "$1" > inverteddata
   ../../bin/bargraph.pl -pdf inverteddata > data.$1.pdf
}

function prodgvn {
    normgraph "1 2 3 4 5 6" gvn > datagvn
    perl ../../bin/bargraph.pl -pdf datagvn > gvndata.pdf
}

function prodsccp {
    normgraph "1 2 3 4 5" sccp > datasccp
    ../../bin/bargraph.pl -pdf datasccp > datasccp.pdf
}

function universe {
    rawgraph2 "$OPTS1" > data1
    rawgraph2 "$OPTS2" > data2
    rawgraph2 "$OPTS3" > data3
    ../../bin/bargraph.pl -pdf data1 > data1.pdf
    ../../bin/bargraph.pl -pdf data2 > data2.pdf
    ../../bin/bargraph.pl -pdf data3 > data3.pdf    
    normgraph "1 2 3 4 5 6" gvn > datagvn
    ../../bin/bargraph.pl -pdf datagvn > datagvn.pdf
    normgraph "1 2 3 4" sccp > datasccp
    ../../bin/bargraph.pl -pdf datasccp > datasccp.pdf
    normgraph "1 2" licm > datalicm
    ../../bin/bargraph.pl -pdf datalicm > datalicm.pdf
    barpipe > data.pipeline
    ../../bin/bargraph.pl -pdf data.pipeline > data.pipeline.pdf    
    #cp data*.pdf $DST 
}
