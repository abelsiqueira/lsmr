# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
# Updated by Abel Soares Siqueira <abel.s.siqueira@gmail.com>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.
# 15 Oct 2014: Updated to use git. See git log for further information

AR = ar rv
LIBNAME = liblsmr.a

FC      =  gfortran
FFLAGS  = -O

CC      =  gcc
CFLAGS  = -O -Wall -Wextra

.SUFFIXES:
.SUFFIXES: .c .f .f90 .o

.f90.o:; ${FC} ${FFLAGS} -c -o $@ $<
.f.o:;   ${FC} ${FFLAGS} -c -o $@ $<
.c.o:;   $(CC) $(CFLAGS) -c -o $@ $<

OBJS = lsmrDataModule.o lsmrModule.o lsmrCheckModule.o
TESTOBJS = lsmrTestModule.o lsmrTestProgram.o

lib: ${OBJS}
	$(AR) $(LIBNAME) $(OBJS)

TestProgram: lib ${TESTOBJS}
	${FC} ${FFLAGS} -o $@ ${TESTOBJS} $(LIBNAME)

clean:
	\rm -f *.o *.mod $(LIBNAME)
