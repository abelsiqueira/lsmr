# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
# Updated by Abel Soares Siqueira <abel.s.siqueira@gmail.com>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.
# 15 Oct 2014: Updated to use git. See git log for further information

SUBMAKES = $(dir $(shell ls */Makefile))

all: lib tests

.PHONY: lib tests
lib tests:
	$(MAKE) -C $@ all

clean purge:
	@for dir in $(SUBMAKES); do $(MAKE) -C $$dir $@; done
