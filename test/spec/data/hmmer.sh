

function hammer() {
  exe=$1
  C=0
  while [ $C -lt 10 ]; do
      $exe hmmer.hmm > /dev/null
      let C=C+1
  done
}

echo no optimization
time hammer ../hmmer.bitcode.none.exe

echo -O1
time hammer ../hmmer.bitcode.O1.exe

echo pipeline
time hammer ../hmmer.bitcode.opt.exe

echo validated
time hammer ../hmmer.bitcode.exe
