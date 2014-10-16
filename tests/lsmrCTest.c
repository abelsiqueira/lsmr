#include <stdio.h>
#include <stdlib.h>

// From LSMR
typedef void (*Aprod_pointer) (int *, int *, double *, double *);
void lsmr(int *, int *, Aprod_pointer, Aprod_pointer, double *, double *, double
    *, double *, double *, int *, int *, int *, double *, int *, int *, double
    *, double *, double *, double *, double *);
void fortran_open(int *, char *, int *);
void fortran_close(int *, int *);
#define UNUSED(x) (void)(x);

void Aprod1 (int *m, int *n, double *x, double *y) {
  int i;
  UNUSED(m);
  for (i = 1; i <= *n; i++) {
    y[0] += x[i-1];
    y[i] += x[i-1];
  }
}

void Aprod2 (int *m, int *n, double *x, double *y) {
  int i;
  UNUSED(m);
  UNUSED(n);
  for (i = 0; i < *n; i++) {
    x[i] += y[0] + y[i+1];
  }
}

int main () {
  int n = 500;
  int m = n + 1;
  double b[m], damp = 0.0, atol = 1.0e-12, btol = atol;
  double conlim = 1.0e6;
  int itnlim = 400, local_size = 0, nout = 10;
  double x[n];
  int istop, itn;
  double normA, condA, normr, normAr, normx;
  double s = 0.0;
  int i, status;
  char output_file[10] = "LSMR.txt";

  for (i = 0; i < m; i++)
    b[i] = 1.0;

  fortran_open(&nout, output_file, &status);
  if (status == 1) {
    printf("Error opening file\n");
    return 1;
  }
  lsmr(&m, &n, Aprod1, Aprod2, b, &damp, &atol, &btol, &conlim, &itnlim,
      &local_size, &nout, x, &istop, &itn, &normA, &condA, &normr, &normAr,
      &normx);
  fortran_close(&nout, &status);

  for (i = 0; i < n; i++)
    s += (x[i] - 2.0/(n+1.0))*(x[i] - 2.0/(n+1.0));

  if (s >= 1e-6)
    return 1;

  printf("All OK\n");

  return 0;
}
