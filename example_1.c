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
    printf("Julian Days start at Noon and is %f\n", djm0 + djm + 0.5);
		printf("Used only if fractional days are to be added %f\n", djm0 + djm);
  }
  //=> Julian Day is 2451545.000000
}