// in C, using the SOFA Library
// put libsofa_c.a in your c lib
// simple compile: gcc -o example_5 example_5.c -lsofa_c

#include <stdio.h>
#include "sofa.h"
#include "sofam.h"

int main() {

	double d, e, d1, d2;
	
	/* Julian Date. */
	d = 2457073.05631;
	printf ( "%13.5f\n", d );
	
	/* Transform into Besselian epoch. */
	e = iauEpb ( 0.0, d );
	printf ( "B%15.10f\n", e );
	
	/* Transform back. */
	iauEpb2jd ( e, &d1, &d2 );
	printf ( "%17.9f\n", d1+d2 );
	
	/* The same for Julian epoch. */
	e = iauEpj ( 0.0, d );
	printf ( "J%15.10f\n", e );
	iauEpj2jd ( e, &d1, &d2 );
	printf ( "%17.9f\n", d1+d2 );	
	
}
// The output (i.e. given JD, Besselian epoch, equivalent JD, Julian epoch, equivalent JD) is:
// 2457073.05631
// B2015.1365941021
// 2457073.056310000
// J2015.1349933196
// 2457073.056310000