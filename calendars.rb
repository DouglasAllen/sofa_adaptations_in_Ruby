
require 'ffi'

module Calendars
  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"  
  
  # int iauCal2jd(int iy, int im, int id, double *djm0, double *djm)
	attach_function :iauCal2jd, [:int, :int, :int, :pointer, :pointer ], :int
	
  # double iauEpb(double dj1, double dj2)
	attach_function :iauEpb, [:double, :double ], :double
	
  # void iauEpb2jd(double epb, double *djm0, double *djm)
	attach_function :iauEpb2jd, [ :double, :pointer, :pointer ], :void
	
  # double iauEpj(double dj1, double dj2)
	attach_function :iauEpj, [ :double, :double ], :double
	
  # void iauEpj2jd(double epj, double *djm0, double *djm)
	attach_function :iauEpj2jd, [ :double, :pointer, :pointer ], :void
	
	# int iauJd2cal(double dj1, double dj2, int *iy, int *im, int *id, double *fd)
  attach_function :iauJd2cal, [ :double, :double, :pointer, :pointer, :pointer, :pointer ], :int
	
  # int iauJdcalf(int ndp, double dj1, double dj2, int iymdf[4])
	attach_function :iauJdcalf, [ :int, :double, :double, :pointer], :int
end
