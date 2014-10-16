AR = ar rv
LIBNAME = liblsmr.a
DEBUG = -g

FC      =  gfortran
FFLAGS  = -O $(DEBUG)

CC      =  gcc
CFLAGS  = -O -Wall -Wextra $(DEBUG) -lm

.SUFFIXES:
.SUFFIXES: .c .f .f90 .o
