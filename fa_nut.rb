require 'ffi'

module FANUT

  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
	
	# FAD03 mean elongation of the Moon from the Sun
	
	# FAE03 mean longitude of Earth
	
	# FAF03 mean argument of the latitude of the Moon
	
	# FAJU03 mean longitude of Jupiter
	
	# FAL03 mean anomaly of the Moon
	
	# FALP03 mean anomaly of the Sun
	
	# FAMA03 mean longitude of Mars
	
	# FAME03 mean longitude of Mercury
	
	# FANE03 mean longitude of Neptune
	
	# FAOM03 mean longitude of the Moon’s ascending node
	
	# FAPA03 general accumulated precession in longitude
	
	# FASA03 mean longitude of Saturn
	
	# FAUR03 mean longitude of Uranus
	
	# FAVE03 mean longitude of Venus
	
end