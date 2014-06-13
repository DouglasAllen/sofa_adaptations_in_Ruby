require 'ffi'

module ERA
  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
  
  # double iauEra00(double dj1, double dj2)
  attach_function :iauEra00, [:double, :double], :double
  
  # double iauGmst00(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst00, [:double, :double, :double, :double], :double
  
  # double iauGmst06(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst06, [:double, :double, :double, :double], :double 
  
  # double iauGmst82(double dj1, double dj2)
  attach_function :iauGmst82, [:double, :double], :double
  
  # double iauGst00a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst00a, [:double, :double, :double, :double], :double
  
  # double iauGst00b(double uta, double utb)
  attach_function :iauGst00b, [:double, :double], :double
  
  # double iauGst06(double uta, double utb, double tta, double ttb, double rnpb[3][3])
  attach_function :iauGst06, [:double, :double, :double, :double, :double], :double
  
  # double iauGst06a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst06a, [:double, :double, :double, :double], :double 
  
  # double iauGst94(double uta, double utb)
  attach_function :iauGst94, [:double, :double], :double  
  
  # void iauA2tf(int ndp, double angle, char *sign, int ihmsf[4])
  attach_function :iauA2tf, [:int, :double, :pointer, :pointer], :void
end