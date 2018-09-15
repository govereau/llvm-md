
NAME ?= fib
OPTS := gvn sccp licm loop-deletion adce dse loop-unswitch pipeline
ASMS := $(addsuffix .s, $(OPTS))
ASTS := $(addsuffix .ast, $(OPTS))
PAIR := $(addprefix m2r., $(addsuffix .astpairs, $(OPTS)))
RES  := $(addprefix results., $(OPTS))

.PHONY: all asts pairs stats clean realclean
.PRECIOUS: m2r.s $(ASMS)
.SUFFIXES:

all: $(RES)
	@sh ../../bin/stats.sh $(RES)

asts: $(NAME).ast m2r.ast $(ASTS)

pairs: $(PAIR)

stats:
	@sh ../../bin/stats.sh results.*

clean:
	rm -f *.[so] *.ast *.astpairs results.*

realclean: clean
	rm -f *.c.*

$(NAME).o: $(NAME).c
	clang -w -emit-llvm -c $<

m2r.o: $(NAME).o
	opt -mem2reg -f -o=$@ $<

%.ast: %.s
	../../validate ast $<

m2r.%.astpairs: %.s m2r.s
	../../validate pairs m2r.s $<

pipeline.o: m2r.o
	opt -adce -gvn -sccp -licm -loop-deletion -loop-unswitch -dse -f -o=$@ $<
%.o: m2r.o
	opt -$* -f -o=$@ $<
%.s: %.o
	llvm-dis -f -o=$@ $<

results.m2r: m2r.s $(NAME).s ../../validate
	@echo Running MD for m2r
	@../../validate $(NAME).s m2r.s > $@

#	@time -p ../../validate $(NAME).s m2r.s > $@

#	@sh ../../bin/stats.sh $@

results.%: %.s m2r.s ../../validate
	../../validate m2r.s $*.s > $@

#	@time -p ../../validate m2r.s $*.s > $@
#	@sh ../../bin/stats.sh $@
