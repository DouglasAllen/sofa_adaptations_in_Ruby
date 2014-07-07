// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_3 example_3.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

	int j, iy, im, id, ihmsf[4];
	double u1, u2, a1, a2, t1, t2;
	
	/* Encode UTC date and time into internal format. */
	j = iauDtf2d ( "UTC", 2010, 7, 24, 11, 18, 7.318, &u1, &u2 );
	if ( j ) return 1;
	
	/* Transform UTC to TAI, then TAI to TT. */
	j = iauUtctai ( u1, u2, &a1, &a2 );
	if ( j ) return 1;
	j = iauTaitt ( a1, a2, &t1, &t2 );
	if ( j ) return 1;
	
	/* Decode and report the TT. */
	j = iauD2dtf ( "tt", 3, t1, t2, &iy, &im, &id, ihmsf );
	if ( j ) return 1;
	printf ( "%4d/%2.2d/%2.2d%3d:%2.2d:%2.2d.%3.3d\n", iy, im, id,
	ihmsf[0], ihmsf[1], ihmsf[2], ihmsf[3] );
}

// The output is “2010/07/24 11:19:13.502”.