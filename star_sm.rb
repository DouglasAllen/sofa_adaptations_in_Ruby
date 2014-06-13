require 'ffi'

module StarSM

  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"

	# Star space motion
	
	# PVSTAR space motion pv−vector to star catalog data
	
	# STARPV star catalog data to space motion pv−vector
	
end