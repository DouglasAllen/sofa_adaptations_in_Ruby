require 'ffi'

module GeoDGeoC

  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
	
	# Geodetic/geocentric
	
	# EFORM a,f for a nominated Earth reference ellipsoid
	
	# GC2GD geocentric to geodetic for a nominated ellipsoid
	
	# GC2GDE geocentric to geodetic given ellipsoid a,f
	
	# GD2GC geodetic to geocentric for a nominated ellipsoid
	
	# GD2GCE geodetic to geocentric given ellipsoid a,f
	
end