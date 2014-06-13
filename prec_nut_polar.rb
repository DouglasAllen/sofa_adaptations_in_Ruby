require 'ffi'

module PrecNutPolar

  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
	
	# BI00 frame bias components, IAU 2000
	
	# BP00 frame bias and precession matrices, IAU 2000
	
	# BP06 frame bias and precession matrices, IAU 2006
	
	# BPN2XY extract CIP X,Y coordinates from NPB matrix
	
	# C2I00A celestial−to−intermediate matrix, IAU 2000A
	
	# C2I00B celestial−to−intermediate matrix, IAU 2000B
	
	# C2I06A celestial−to−intermediate matrix, IAU 2006/2000A
	
	# C2IBPN celestial−to−intermediate matrix, given NPB matrix, IAU 2000
	
	# C2IXY celestial−to−intermediate matrix, given X,Y, IAU 2000
	
	# C2IXYS celestial−to−intermediate matrix, given X,Y and s
	
	# C2T00A celestial−to−terrestrial matrix, IAU 2000A
	
	# C2T00B celestial−to−terrestrial matrix, IAU 2000B
	
	# C2T06A celestial−to−terrestrial matrix, IAU 2006/2000A
	
	# C2TCIO form CIO−based celestial−to−terrestrial matrix
	
	# C2TEQX form equinox−based celestial−to−terrestrial matrix
	
	# C2TPE celestial−to−terrestrial matrix given nutation, IAU 2000
	
	# C2TXY celestial−to−terrestrial matrix given CIP, IAU 2000
	
	# EO06A equation of the origins, IAU 2006/2000A
	
	# EORS equation of the origins, given NPB matrix and s
	
	# FW2M Fukushima−Williams angles to r−matrix
	
	# FW2XY Fukushima−Williams angles to X,Y
	
	# NUM00A nutation matrix, IAU 2000A
	
	# NUM00B nutation matrix, IAU 2000B
	
	# NUM06A nutation matrix, IAU 2006/2000A
	
	# NUMAT form nutation matrix
	
	# NUT00A nutation, IAU 2000A
	
	# NUT00B nutation, IAU 2000B
	
	# NUT06A nutation, IAU 2006/2000A
	
	# NUT80 nutation, IAU 1980
	
	# NUTM80 nutation matrix, IAU 1980
	
	# OBL06 mean obliquity, IAU 2006
	
	# OBL80 mean obliquity, IAU 1980
	
	# PB06 zeta,z,theta precession angles, IAU 2006, including bias
	
	# PFW06 bias−precession Fukushima−Williams angles, IAU 2006
	
	# PMAT00 precession matrix (including frame bias), IAU 2000
	
	# PMAT06 PB matrix, IAU 2006
	
	# PMAT76 precession matrix, IAU 1976
	
	# PN00 bias/precession/nutation results, IAU 2000
	
	# PN00A bias/precession/nutation, IAU 2000A
	
	# PN00B bias/precession/nutation, IAU 2000B
	
	# PN06 bias/precession/nutation results, IAU 2006
	
	# PN06A bias/precession/nutation results, IAU 2006/2000A
	
	# PNM00A classical NPB matrix, IAU 2000A
	
	# PNM00B classical NPB matrix, IAU 2000B
	
	# PNM06A classical NPB matrix, IAU 2006/2000A
	
	# PNM80 precession/nutation matrix, IAU 1976/1980
	
	# P06E precession angles, IAU 2006, equinox based
	
	# POM00 polar motion matrix
	
	# PR00 IAU 2000 precession adjustments
	
	# PREC76 accumulated precession angles, IAU 1976
	
	# S00 the CIO locator s, given X,Y, IAU 2000A
	
	# S00A the CIO locator s, IAU 2000A
	
	# S00B the CIO locator s, IAU 2000B
	
	# S06 the CIO locator s, given X,Y, IAU 2006
	
	# S06A the CIO locator s, IAU 2006/2000A
	
	# SP00 the TIO locator s’, IERS 2003
	
	# XY06 CIP, IAU 2006/2000A, from series
	
	# XYS00A CIP and s, IAU 2000A
	
	# XYS00B CIP and s, IAU 2000B
	
	# XYS06A CIP and s, IAU 2006/2000A
	
end