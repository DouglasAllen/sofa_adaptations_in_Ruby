require 'ffi'

module Ephemerides
  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'
	
	# EPV00 Earth position and velocity
	# int iauEpv00(double date1, double date2,
               # double pvh[2][3], double pvb[2][3])
	attach_function :iauEpv00, [:double, :double, :pointer, :pointer], :int						 
							 
  # PLAN94 major−planet position and velocity
	# int iauPlan94(double date1, double date2, int np, double pv[2][3])
	attach_function :iauPlan94, [:double, :double, :int, :pointer], :int

end	