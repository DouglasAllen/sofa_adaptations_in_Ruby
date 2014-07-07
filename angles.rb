require 'ffi'

module Angles
  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'	
	
	# A2AF decompose radians into degrees, arcminutes, arcseconds
	# void iauA2af(int ndp, double angle, char *sign, int idmsf[4])
	attach_function :iauA2af, [:int, :double, :pointer, :pointer], :void
	
	# A2TF decompose radians into hours, minutes, seconds
	# void iauA2tf(int ndp, double angle, char *sign, int ihmsf[4])
	attach_function :iauA2tf, [:int, :double, :pointer, :pointer], :void
	
	# AF2A degrees, arcminutes, arcseconds to radians
	# int iauAf2a(char s, int ideg, int iamin, double asec, double *rad)
	attach_function :iauAf2a, [:string, :int, :int, :double, :double], :int
	
	# D2TF decompose days into hours, minutes, seconds
	# void iauD2tf(int ndp, double days, char *sign, int ihmsf[4])
	attach_function :iauD2tf, [:int, :double, :pointer, :pointer], :void
	
	# ANP normalize radians to range 0 to 2pi
	# double iauAnp(double a)
	attach_function :iauAnp, [:double], :double
	
	# ANPM normalize radians to range −pi to +pi
	# double iauAnpm(double a)
	attach_function :iauAnpm, [:double], :double
	
	# TF2A hours, minutes, seconds to radians
	# int iauTf2a(char s, int ihour, int imin, double sec, double *rad)
	attach_function :iauTf2a, [:string, :int, :int, :double, :pointer], :int
	
	# TF2D hours, minutes, seconds to days
	# int iauTf2d(char s, int ihour, int imin, double sec, double *days)
	attach_function :iauTf2d, [:string, :int, :int, :double, :pointer], :int
	
end