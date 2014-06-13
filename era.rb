require 'ffi'

module ERA
  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"	
  
	# EE00 equation of the equinoxes, IAU 2000
	# double iauEe00(double date1, double date2, double epsa, double dpsi)
	attach_function :iauEe00, [:double, double, :double, :double], :double
	
	# EE00A equation of the equinoxes, IAU 2000A
	# double iauEe00a(double date1, double date2)
	attach_function :iauEe00a, [:double, :double], :double 
	
	# EE00B equation of the equinoxes, IAU 2000B
	# double iauEe00b(double date1, double date2)
	attach_function :iauEe00b, [:double, :double], :double
	
	# EE06A equation of the equinoxes, IAU 2006/2000A
	# double iauEe06a(double date1, double date2)
	attach_function :iauEe06a, [:double, :double], :double
	
	# EECT00 equation of the equinoxes complementary terms, IAU 2000
	# double iauEect00(double date1, double date2)
	attach_function :iauEect00, [:double, :double], :double
	
	# EQEQ94 equation of the equinoxes, IAU 1994
	# double iauEqeq94(double date1, double date2)
	attach_function :iauEqeq94, [:double, :double], :double
	
	# ERA00 Earth rotation angle, IAU 2000
  # double iauEra00(double dj1, double dj2)
  attach_function :iauEra00, [:double, :double], :double
  
	# GMST00 Greenwich mean sidereal time, IAU 2000
  # double iauGmst00(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst00, [:double, :double, :double, :double], :double
  
	# GMST06 Greenwich mean sidereal time, IAU 2006
  # double iauGmst06(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst06, [:double, :double, :double, :double], :double 
  
	# GMST82 Greenwich mean sidereal time, IAU 1982
  # double iauGmst82(double dj1, double dj2)
  attach_function :iauGmst82, [:double, :double], :double
  
	# GST00A Greenwich apparent sidereal time, IAU 2000A
  # double iauGst00a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst00a, [:double, :double, :double, :double], :double
  
	# GST00B Greenwich apparent sidereal time, IAU 2000B
  # double iauGst00b(double uta, double utb)
  attach_function :iauGst00b, [:double, :double], :double
  
	# GST06 Greenwich apparent ST, IAU 2006, given NPB matrix
  # double iauGst06(double uta, double utb, double tta, double ttb, double rnpb[3][3])
  attach_function :iauGst06, [:double, :double, :double, :double, :double], :double
  
	# GST06A Greenwich apparent sidereal time, IAU 2006/2000A
  # double iauGst06a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst06a, [:double, :double, :double, :double], :double 
  
	# GST94 Greenwich apparent sidereal time, IAU 1994
  # double iauGst94(double uta, double utb)
  attach_function :iauGst94, [:double, :double], :double  
  
end