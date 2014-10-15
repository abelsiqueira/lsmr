# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
# Updated by Abel Soares Siqueira <abel.s.siqueira@gmail.com>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.
# 15 Oct 2014: Updated to use git. See git log for further information

include ../make.inc

F90TESTS = $(shell ls lsmr*.f90 | grep -v Module | sed 's/.f90//g')

all test: $(F90TESTS)
	@for tst in *.tst; do echo -e "\033[0;33mRunning $$tst\033[0m"; ./$$tst; done

$(F90TESTS): %: %.f90
	@echo -e "\033[0;32mCompiling $@\033[0m"
	@if [ -f $@Module.f90 ]; then \
		target="$@Module.f90 $@.f90"; \
	else \
		target="$@.f90"; \
	fi; \
	${FC} ${FFLAGS} -o $@.tst $$target -I../lib ../lib/$(LIBNAME)

clean purge:
	rm -f *.o *.mod $(patsubst %,%.tst,$(F90TESTS))
