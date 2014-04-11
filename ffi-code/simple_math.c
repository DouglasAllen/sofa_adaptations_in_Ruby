// Simple FFI example between C & Ruby
#include <math.h>

double power(double base, double power) {
  return pow(base, power);
}

double square_root(double x) {
  return sqrt(x);
}

// custom factorial function which we'll call from Ruby

long ffi_factorial(int max) {
  int i = max, result = 1;
  while (i >= 2) {
    result *= i--;
  }
  return result;
}

// Compiling shared library:
// gcc -shared -Wl,-soname,libsimplemath -o libsimplemath.so simple_math.c -lm