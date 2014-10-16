# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
# Updated by Abel Soares Siqueira <abel.s.siqueira@gmail.com>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.
# 15 Oct 2014: Updated to use git. See git log for further information

include ../make.inc

F90TESTS = $(shell ls lsmr*.f90 | grep -v Module | sed 's/.f90//g')
CTESTS = $(patsubst %.c,%,$(wildcard *.c))
TESTS = $(F90TESTS) $(CTESTS)

all test: $(TESTS)
	@for tst in *.tst; do echo -e "\033[0;33mRunning $$tst\033[0m"; \
		./$$tst; if [ $$? -eq 1 ]; then \
			echo -e "\033[0;31mFAILURE\033[0m" && exit 0; fi; done

$(F90TESTS): %: %.f90
	@echo -e "\033[0;32mCompiling $@\033[0m"
	@if [ -f $@Module.f90 ]; then \
		target="$@Module.f90 $@.f90"; \
	else \
		target="$@.f90"; \
	fi; \
	${FC} ${FFLAGS} -o $@.tst $$target -I../lib ../lib/$(LIBNAME)

$(CTESTS): %: %.c
	@echo -e "\033[0;32mCompiling $@\033[0m"
	${CC} ${CFLAGS} -o $@.tst $@.c -I../lib ../lib/$(LIBNAME) -lgfortran

clean purge:
	rm -f *.o *.mod $(patsubst %,%.tst,$(TESTS))
