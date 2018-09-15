
C := $(shell ls *.c)
O := $(addsuffix .o, $(basename $(C)))

.PHONY: all clean
.SUFFIXES:

all: m2r.s gvn.s inlined.s

clean:
	rm -f *.s *.o *.nm

all.o: $(O)
	llvm-link -o=$@ $?

m2r.o: all.o
	opt -mem2reg -o=$@ $<

gvn.o: m2r.o
	opt -gvn -o=$@ $<

inlined.o: m2r.o
	opt -inline -o=$@ $<

%.o: %.c
	clang -emit-llvm -c $<
%.s: %.o
	llvm-nm $< > $*.nm
	llvm-dis -f -o=$@ $<
