#ifndef lsmr_h
#define lsmr_h

#ifdef __cplusplus
extern "C" {
#endif
typedef void (*Aprod_pointer) (
    int *,    // nrow
    int *,    // ncol
    double *, // x(ncol)
    double *  // y(nrow)
    );
void lsmr(
    int *,          // nrow
    int *,          // ncol
    Aprod_pointer,  // y <- y + Ax
    Aprod_pointer,  // x <- x + A'y
    double *,       // b(nrow)
    double *,       // damp
    double *,       // atol
    double *,       // btol
    double *,       // conlim
    int *,          // itnlim
    int *,          // local_size
    int *,          // nout (call fortran_open before)
    double *,       // x(ncol) (out)
    int *,          // istop (out)
    int *,          // itn (out)
    double *,       // normA (out)
    double *,       // condA (out)
    double *,       // normr (out)
    double *,       // normAr (out)
    double *        // normx (out)
    );
void fortran_open(
    int *,  // nout
    char *, // output file
    int *   // status
    );
void fortran_close(
    int *,  // nout
    int *   // status
    );

#ifdef __cplusplus
}
#endif

#endif
