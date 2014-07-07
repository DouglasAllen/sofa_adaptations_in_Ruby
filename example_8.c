// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_8 example_8.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

	int j;
	double deltat;
	
	/* TAI-UTC for 0h UTC on 2009 Feb 13. */
	j = iauDat ( 2009, 2, 13, 0.0, &deltat );
	if ( j ) return 1;
	printf ( "%+5.1f", deltat );
}
// The output is “+34.0”