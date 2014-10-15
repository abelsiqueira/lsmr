# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
# Updated by Abel Soares Siqueira <abel.s.siqueira@gmail.com>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.
# 15 Oct 2014: Updated to use git. See git log for further information

AR = ar rv
LIBNAME = liblsmr.a
DEBUG = -g

FC      =  gfortran
FFLAGS  = -O $(DEBUG)

CC      =  gcc
CFLAGS  = -O -Wall -Wextra $(DEBUG)

.SUFFIXES:
.SUFFIXES: .c .f .f90 .o

.f90.o:; ${FC} ${FFLAGS} -c -o $@ $<
.f.o:;   ${FC} ${FFLAGS} -c -o $@ $<
.c.o:;   $(CC) $(CFLAGS) -c -o $@ $<

OBJS = lsmrDataModule.o lsmrModule.o lsmrCheckModule.o

TESTOBJS = lsmrTestModule.o lsmrTestProgram.o
LSMRSMALLTEST = lsmrSmallLSTest.o

lib: $(LIBNAME)

$(LIBNAME): ${OBJS}
	$(AR) $(LIBNAME) $(OBJS)

TestProgram: $(LIBNAME) ${TESTOBJS}
	${FC} ${FFLAGS} -o $@ ${TESTOBJS} $(LIBNAME)
	./$@

smalltests: lib $(LSMRSMALLTEST)
	${FC} ${FFLAGS} -o SmallLSTest $(LSMRSMALLTEST) $(LIBNAME)

clean:
	\rm -f *.o *.mod $(LIBNAME)
