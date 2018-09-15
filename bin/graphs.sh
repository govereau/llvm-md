#!/bin/sh
for f in *.dot; do
    echo $f
    dot -Tpdf -O $f
done
