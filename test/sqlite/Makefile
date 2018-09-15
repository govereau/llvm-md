
OPTS := gvn sccp licm loop-deletion adce dse loop-unswitch
ASMS := $(addsuffix .s, $(OPTS))
ASTS := $(addsuffix .ast, $(OPTS))
PAIR := $(addprefix m2r., $(addsuffix .astpairs, $(OPTS)))
RES  := $(addprefix results., $(OPTS))

.PHONY: all asts pairs stats clean
.PRECIOUS: m2r.s $(ASMS)
.SUFFIXES:

all: $(RES)
	@sh ../../bin/stats.sh $(RES)

asts: sqlite3.ast m2r.ast $(ASTS)

pairs: $(PAIR)

stats:
	@sh ../../bin/stats.sh results.*

clean:
	rm -f *.[so] *.ast *.astpairs results.*

sqlite3.o: sqlite3.c
	clang -w -emit-llvm -c $<

m2r.o: sqlite3.o
	opt -mem2reg -f -o=$@ $<

%.ast: %.s
	../../validate ast $<

m2r.%.astpairs: %.s m2r.s
	../../validate pairs m2r.s $<

%.o: m2r.o
	opt -$* -f -o=$@ $<
%.s: %.o
	llvm-dis -f -o=$@ $<

results.m2r: m2r.s sqlite3.s ../../validate
	@echo Running MD for m2r
	@time -p ../../validate sqlite3.s m2r.s > $@
	@sh ../../bin/stats.sh $@

results.%: %.s m2r.s ../../validate
	@echo Running MD for $*
	@time -p ../../validate m2r.s $*.s > $@
	@sh ../../bin/stats.sh $@
