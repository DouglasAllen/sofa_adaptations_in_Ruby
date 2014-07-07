// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_1 example_1.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

  int iy, im, id, ihour, imin, j, iymdf[4];
  double d1, d2, sec, d, fd;
	
	printf("\n");
	
	/* Date and time. */
	iy = 2008; im = 2; id = 29;
	ihour = 23; imin = 59; sec = 59.9;
	printf ( "* Date and time. *\n" );
	printf ( "%4d/%2.2d/%2.2d%3d:%2.2d:%4.1f\n",
	iy, im, id, ihour, imin, sec );
	
	printf("\n");
	
	/* Express as 2-part JD. */
	j = iauCal2jd ( iy, im, id, &d1, &d2 );
	if ( j ) return 1;
	  j = iauTf2d ( '+', ihour, imin, sec, &d );
	if ( j ) return 1;
	  d2 += d;
	printf("* Express as 2-part JD. *\n");
	printf ( "%9.1f +%13.6f =%15.6f\n", d1, d2, d1 + d2 );
	
	printf("\n");
	
	/* Express as calendar date and fraction of a day. */
  j = iauJd2cal ( d1, d2, &iy, &im, &id, &fd );
  if ( j ) return 1;
    d = ( (double) id ) + fd;
  printf("* Express as calendar date and fraction of a day. *\n");
	printf ( "%4d/%2.2d/%9.6f\n", iy, im, d );
	
	printf("\n");
	
	/* Round to 0.001 day. */
  j = iauJdcalf ( 3, d1, d2, iymdf );
	printf("* Round to 0.001 day. *\n");
  if ( j ) return 1;
    printf ( "%4d/%2.2d/%2.2d.%3.3d\n",
    iymdf[0], iymdf[1], iymdf[2], iymdf[3] );
}