include ../make.inc

OBJS = lsmrDataModule.o lsmrModule.o lsmrCheckModule.o

%.o: ../src/%.f90
	${FC} ${FFLAGS} -c -o $@ $<

all lib: $(LIBNAME)

$(LIBNAME): ${OBJS}
	$(AR) $(LIBNAME) $(OBJS)

clean:
	\rm -f *.o *.mod $(LIBNAME)

purge: clean
