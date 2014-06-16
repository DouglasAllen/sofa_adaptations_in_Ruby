// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_1 example_1.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

  int status;
  double djm0, djm;

  status = iauCal2jd(2000, 1, 1, &djm0, &djm);

  if(status){
    printf("error or warning\n");
  } else{
    printf("* Julian Days start at Noon *\n");
		printf("%f\n", djm0 + djm + 0.5);
		printf("\n");
		printf("* Used if fractional days (time) to be added *\n");
		printf("%f\n", djm0 + djm);
  } 	
	
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
		
	double e;
	
	printf("\n");
	
	/* Julian Date. */
	d = 2457073.05631;
	printf("* Julian Date. *\n");
	printf ( "%13.5f\n", d );
	
	printf("\n");
	
	/* Transform into Besselian epoch. */
	e = iauEpb ( 0.0, d );
	printf("* Transform into Besselian epoch. *\n");
	printf ( "B%15.10f\n", e );
	
	printf("\n");
	
	/* Transform back. */
	iauEpb2jd ( e, &d1, &d2 );
	printf("* Transform back. *\n");
	printf ( "%17.9f\n", d1+d2 );

  printf("\n");

  /* The same for Julian epoch. */
	printf("* The same for Julian epoch. *\n");
	e = iauEpj ( 0.0, d );
	printf ( "J%15.10f\n", e );
	iauEpj2jd ( e, &d1, &d2 );
	printf ( "%17.9f\n", d1+d2 );	
}