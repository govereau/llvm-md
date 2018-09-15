#!/bin/sh

rm -rf doc
mkdir -p doc
HS=`find MD -name "*.hs" | grep -v GenerateSmt | grep -v STTree | grep -v Structural | grep -v Symbolic | grep -v Rewrite`
for f in ${HS}; do
    g=`echo $f | sed -e "s|.hs||g" -e "s|/|.|g"`
    echo $f $g
    HsColour -html -anchor $f > doc/$g.html
done

cat >doc/info.txt <<EOF
This is a research prototype of a
denotational translation validator for a subset of LLVM.

Please see <http://llvm-md.seas.harvard.edu> for more infomation.
EOF
haddock --optghc="-XExistentialQuantification" \
    -o doc -h --use-index="index.html" \
    -t "LLVM M.D." -w -p doc/info.txt ${HS} \
    --source-module="%{MODULE}.html" \
    --source-entity="%{MODULE}.html#%{NAME}"

rm -f doc/mini* doc/index-frames.html doc/frames.html doc/info.txt
