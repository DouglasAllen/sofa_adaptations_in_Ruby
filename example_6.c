// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_6 example_6.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

	int j, iy, im, id, ihmsf[4];
	double a1, a2, u1, u2;
	
	/* Encode TAI date and time into internal format. */
	j = iauDtf2d ( "TAI", 2009, 1, 1, 0, 0, 33.7, &a1, &a2 );
	if ( j ) return 1;
	
	/* Decode and report the TAI. */
	j = iauD2dtf ( "TAI", 3, a1, a2, &iy, &im, &id, ihmsf );
	if ( j ) return 1;
	printf ( "TAI %4d/%2.2d/%2.2d%3d:%2.2d:%2.2d.%3.3d\n",
	iy, im, id, ihmsf[0], ihmsf[1], ihmsf[2], ihmsf[3] );
	
	/* Transform TAI to UTC. */
	j = iauTaiutc ( a1, a2, &u1, &u2 );
	if ( j ) return 1;
	
	/* Decode and report the UTC. */
	j = iauD2dtf ( "UTC", 3, u1, u2, &iy, &im, &id, ihmsf );
	if ( j ) return 1;
	printf ( "UTC %4d/%2.2d/%2.2d%3d:%2.2d:%2.2d.%3.3d\n",
	iy, im, id, ihmsf[0], ihmsf[1], ihmsf[2], ihmsf[3] );
}

// The output is:
// TAI 2009/01/01 0:00:33.700
// UTC 2008/12/31 23:59:60.700