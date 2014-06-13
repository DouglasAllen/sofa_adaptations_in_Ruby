require 'ffi'

module Angles
  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'
	
	# void iauA2af(int ndp, double angle, char *sign, int idmsf[4])
	attach_function :iauA2af, [:int, :double, :pointer, :pointer], :void
	
	# void iauA2tf(int ndp, double angle, char *sign, int ihmsf[4])
	attach_function :iauA2tf, [:int, :double, :pointer, :pointer], :void
	
	# void iauD2tf(int ndp, double days, char *sign, int ihmsf[4])
	attach_function :iauD2tf, [:int, :double, :pointer, :pointer], :void
	
	# double iauAnp(double a)
	attach_function :iauAnp, [:double], :double
	
	# double iauAnpm(double a)
	attach_function :iauAnpm, [:double], :double
	
	# int iauTf2a(char s, int ihour, int imin, double sec, double *rad)
	attach_function :iauTf2a, [:string, :int, :int, :double, :pointer], :int
	
	# int iauTf2d(char s, int ihour, int imin, double sec, double *days)
	attach_function :iauTf2d, [:string, :int, :int, :double, :pointer], :int
	
end