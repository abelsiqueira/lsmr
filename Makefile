# Makefile for F90 version of LSMR.
# Maintained by Michael Saunders <saunders@stanford.edu>
#
# 16 Jul 2010: LSMR version derived from LSQR equivalent.

  FC      =  gfortran
  FFLAGS  = -g -O
# FFLAGS  = -g -O0 -pedantic -Wall -Wextra -fbounds-check -ftrace=full

  CC      =  gcc
  CFLAGS  = -g -O

# Clear suffix list, then define the ones we want
  .SUFFIXES:
  .SUFFIXES: .c .f .f90 .o

  .f90.o:; ${FC} ${FFLAGS} -c -o $@ $<
  .f.o:;   ${FC} ${FFLAGS} -c -o $@ $<
  .c.o:;   $(CC) $(CFLAGS) -c -o $@ $<

  files = lsmrDataModule.o                                       \
          lsmrModule.o     lsmrCheckModule.o lsmrTestModule.o    \
          lsmrTestProgram.o

TestProgram: ${files}
	${FC} ${FFLAGS} -o $@ ${files}

clean:
	\rm -f *.o *.mod
