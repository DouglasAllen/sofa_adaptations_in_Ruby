require 'ffi'

module Astrometry
  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'
	
	# AB apply stellar aberration
	# void iauAb(double pnat[3], double v[3], double s, double bm1, 
	           # double ppr[3])
	
	
	# APCG prepare for ICRS <−> GCRS, geocentric, special
	# void iauApcg(double date1, double date2, 
	             # double ebpv[2][3], double ehp[3], 
							 # iauASTROM *astrom)
	

	# APCG13 prepare for ICRS <−> GCRS, geocentric
	# void iauApcg13(double date1, double date2, iauASTROM *astrom)
	

	# APCI prepare for ICRS <−> CIRS, terrestrial, special
	# void iauApci(double date1, double date2, 
	             # double ebpv[2][3], double ehp[3], 
							 # double x, double y, double s, 
							 # iauASTROM *astrom)

	
	# APCI13 prepare for ICRS <−> CIRS, terrestrial
	# void iauApci13(double date1, double date2, 
	               # iauASTROM *astrom, double *eo)
	
	
	# APCO prepare for ICRS <−> observed, terrestrial, special
	# void iauApco(double date1, double date2,
               # double ebpv[2][3], double ehp[3],
               # double x, double y, double s, double theta,
               # double elong, double phi, double hm,
               # double xp, double yp, double sp,
               # double refa, double refb,
               # iauASTROM *astrom)
	

	# APCO13 prepare for ICRS <−> observed, terrestrial
	# int iauApco13(double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # iauASTROM *astrom, double *eo)
							

	# APCS prepare for ICRS <−> CIRS, space, special
	# void iauApcs(double date1, double date2, double pv[2][3],
               # double ebpv[2][3], double ehp[3],
               # iauASTROM *astrom)

	# APCS13 prepare for ICRS <−> CIRS, space
	# void iauApcs13(double date1, double date2, double pv[2][3],
                 # iauASTROM *astrom)
								 

	# APER insert ERA into context
	# void iauAper(double theta, iauASTROM *astrom)
	

	# APER13 update context for Earth rotation
	# void iauAper13(double ut11, double ut12, iauASTROM *astrom)
	

	# APIO prepare for CIRS <−> observed, terrestrial, special
	# void iauApio(double sp, double theta,
               # double elong, double phi, double hm, double xp, double yp,
               # double refa, double refb,
               # iauASTROM *astrom)
							 

	# APIO13 prepare for CIRS <−> observed, terrestrial
	# int iauApio13(double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # iauASTROM *astrom)
							

	# ATCI13 catalog −> CIRS
	# void iauAtci13(double rc, double dc,
                 # double pr, double pd, double px, double rv,
                 # double date1, double date2,
                 # double *ri, double *di, double *eo)
								 

	# ATCIQ quick ICRS −> CIRS
	# void iauAtciq(double rc, double dc,
                # double pr, double pd, double px, double rv,
                # iauASTROM *astrom, double *ri, double *di)
								

	# ATCIQN quick ICRS −> CIRS, multiple deflections
	# void iauAtciqn(double rc, double dc, double pr, double pd,
                 # double px, double rv, iauASTROM *astrom,
                 # int n, iauLDBODY b[], double *ri, double *di)
								 

	# ATCIQZ quick astrometric ICRS −> CIRS
	# void iauAtciqz(double rc, double dc, iauASTROM *astrom,
                 # double *ri, double *di)
								 

	# ATCO13 ICRS −> observed
	# int iauAtco13(double rc, double dc,
                # double pr, double pd, double px, double rv,
                # double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # double *aob, double *zob, double *hob,
                # double *dob, double *rob, double *eo)
								

	# ATIC13 CIRS −> ICRS
	# void iauAtic13(double ri, double di, double date1, double date2,
                 # double *rc, double *dc, double *eo)
								 

	# ATICQ quick CIRS −> ICRS
	# void iauAticq(double ri, double di, iauASTROM *astrom,
                # double *rc, double *dc)
								

	# ATICQN quick CIRS −> ICRS, multiple deflections
	# void iauAticqn(double ri, double di, iauASTROM *astrom,
                 # int n, iauLDBODY b[], double *rc, double *dc)
								 

	# ATIO13 CIRS −> observed
	# int iauAtio13(double ri, double di,
                # double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # double *aob, double *zob, double *hob,
                # double *dob, double *rob)
								

	# ATIOQ quick CIRS −> observed
	# void iauAtioq(double ri, double di, iauASTROM *astrom,
                # double *aob, double *zob,
                # double *hob, double *dob, double *rob)
								

	# ATOC13 observed −> astrometric ICRS
	# int iauAtoc13(const char *type, double ob1, double ob2,
                # double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # double *rc, double *dc)
								

	# ATOI13 observed −> CIRS
	# int iauAtoi13(const char *type, double ob1, double ob2,
                # double utc1, double utc2, double dut1,
                # double elong, double phi, double hm, double xp, double yp,
                # double phpa, double tc, double rh, double wl,
                # double *ri, double *di)
								

	# ATOIQ quick observed −> CIRS
	# void iauAtoiq(const char *type,
                # double ob1, double ob2, iauASTROM *astrom,
                # double *ri, double *di)
								

	# LD light deflection by a single solar−system body
	# void iauLd(double bm, double p[3], double q[3], double e[3],
             # double em, double dlim, double p1[3])
						 

	# LDN light deflection by multiple solar−system bodies
	# void iauLdn(int n, iauLDBODY b[], double ob[3], double sc[3],
              # double sn[3])
							

	# LDSUN light deflection by the Sun
	# void iauLdsun(double p[3], double e[3], double em, double p1[3])
	

	# PMPX apply proper motion and parallax
	# void iauPmpx(double rc, double dc, double pr, double pd,
               # double px, double rv, double pmt, double pob[3],
               # double pco[3])
							 

	# PVTOB observatory position and velocity
	# void iauPvtob(double elong, double phi, double hm,
                # double xp, double yp, double sp, double theta,
                # double pv[2][3])
								

	# REFCO refraction constants
  # void iauRefco(double phpa, double tc, double rh, double wl,
                # double *refa, double *refb)
								
end