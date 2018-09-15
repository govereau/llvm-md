# A very simple makefile

.PHONY: clean prof clean_prof
.SUFFIXES:
.SECONDARY:

FLAGS := -Wall -fno-warn-unused-do-bind
HS := $(shell find . -name "*hs") MD/Binary.hs

validate: ${HS}
	ghc ${FLAGS} -threaded --make -O2 validate.hs
	strip validate

MD/Binary.hs: bin/genBinary.hs
	runghc bin/genBinary.hs > $@

validate.hp: validate
	ghc ${FLAGS} --make -O2 \
	-prof -auto-all -osuf prof \
	-o validate.hp validate.hs

validate.hp.hp: validate.hp
	./validate pairs a b
	./validate.hp a b +RTS -p -hc

validate.hp.ps: validate.hp.hp
	hp2ps -c validate.hp.hp

prof: validate.hp.ps
	open validate.hp.ps

clean:
	@rm -f validate.hp.*
	@find . -name "*.hi" -delete \
	-or -name "*.o" -delete -or -name "*.prof" \
	-delete -name "*~" -delete
	@rm -rf doc validate validate.hp

clobber: clean
	@rm -f MD/Binary.hs
	@rm -f bin/runfor
	@find . -name "*.ast" -delete -or -name "*.astpairs" -delete
	@rm -f test/spec/*.[os] test/spec/r.*
	@rm -f test/sqlite/*.s test/sqlite/results.*
	@find . -name "*.dot" -delete \
	-or -name "*.png" -delete \
	-or -name "*.pdf" -delete \
	-or -name ".DS_Store" -delete
