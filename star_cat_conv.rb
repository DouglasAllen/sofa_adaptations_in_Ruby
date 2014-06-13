require 'ffi'

module StarCC

  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
	
	# Star catalog conversions
	
	# FK52H transform FK5 star data into the Hipparcos system
	
	# FK5HIP FK5 to Hipparcos rotation and spin
	
	# FK5HZ FK5 to Hipparcos assuming zero Hipparcos proper motion
	
	# H2FK5 transform Hipparcos star data into the FK5 system
	
	# HFK5Z Hipparcos to FK5 assuming zero Hipparcos proper motion
	
	# PMSAFE apply proper motion, with zero−parallax precautions
	
	# STARPM apply proper motion
	
end