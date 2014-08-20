// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: 
// mingw: gcc -o example_4 example_4.c -lsofa_c
// linux: gcc -o example_4 example_4.c -I./include -L./lib/ -lsofa_c -lm

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

  char pm;
  int ih, im, j, ihmsf[4];
  double s, f;

  /* The time. */
  ih = 23;
  im = 5;
  s = 11.630799;
  printf ( "%2d:%2.2d:%9.6f\n", ih, im, s );

  /* Express as a fraction of 1 day. */
  j = iauTf2d ( '+', ih, im, s, &f );
  if ( j ) return 1;	
  printf ( "%14.12f\n", f );

  /* Six hours earlier. */
  f -= 0.25;

  /* Report to 1 ms precision. */
  iauD2tf ( 3, f, &pm, ihmsf );
  printf ( "%2d:%2.2d:%2.2d.%3.3d\n",
    ihmsf[0], ihmsf[1], ihmsf[2], ihmsf[3] );
}

// The output (i.e. test time, equivalent fraction of a day, time six hours earlier) is:
// 23:05:11.630799
// 0.961940171285
// 17:05:11.631