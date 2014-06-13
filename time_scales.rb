
require 'ffi'

module Time_Scales

  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'
	
  ## int iauD2dtf(const char *scale, int ndp, double d1, double d2, int *iy, int *im, int *id, int ihmsf[4])
  attach_function :iauD2dtf, [:string, :int, :double, :double, :pointer, :pointer, :pointer, :pointer], :int
	
  ## void iauD2tf(int ndp, double days, char *sign, int ihmsf[4])
  attach_function :iauD2tf, [:int, :double, :pointer, :pointer], :void
	
  ## int iauDat(int iy, int im, int id, double fd, double *deltat )
  attach_function :iauDat, [:int, :int, :int, :double, :pointer], :int
	
  # double iauDtdb(double date1, double date2, double ut, double elong, double u, double v)
  attach_function :iauDtdb, [:double, :double, :double, :double, :double, :double], :double
	
  ## int iauDtf2d(const char *scale, int iy, int im, int id, int ihr, int imn, double sec, double *d1, double *d2)
  attach_function :iauDtf2d, [:string, :int, :int, :int, :int, :int, :double, :pointer, :pointer], :int
  
  ## int iauTaitt(double tai1, double tai2, double *tt1, double *tt2)
  attach_function :iauTaitt, [:double, :double, :pointer, :pointer], :int
	
  ## int iauTaiut1(double tai1, double tai2, double dta, double *ut11, double *ut12)
  attach_function :iauTaiut1, [:double, :double, :double, :pointer, :pointer], :int
	
  ## int iauTaiutc(double tai1, double tai2, double *utc1, double *utc2)
  attach_function :iauTaiutc, [:double, :double, :pointer, :pointer], :int
	
  # int iauTcbtdb(double tcb1, double tcb2, double *tdb1, double *tdb2)
  attach_function :iauTcbtdb, [:double, :double, :pointer, :pointer], :int
	
  # int iauTcgtt(double tcg1, double tcg2, double *tt1, double *tt2)
  attach_function :iauTcgtt, [:double, :double, :pointer, :pointer], :int
	
  # int iauTdbtcb(double tdb1, double tdb2, double *tcb1, double *tcb2)
  attach_function :iauTdbtcb, [:double, :double, :pointer, :pointer], :int
	
  # int iauTdbtt(double tdb1, double tdb2, double dtr, double *tt1, double *tt2 )
  attach_function :iauTdbtt, [:double, :double, :double, :pointer, :pointer], :int
	
  ## int iauTttai(double tt1, double tt2, double *tai1, double *tai2)  
  attach_function :iauTttai, [:double, :double, :pointer, :pointer ], :int 
	
  # int iauTttcg(double tt1, double tt2, double *tcg1, double *tcg2)
  attach_function :iauTttcg, [:double, :double, :pointer, :pointer], :int
	
  ## int iauTttdb(double tt1, double tt2, double dtr, double *tdb1, double *tdb2)
  attach_function :iauTttdb, [:double, :double, :double, :pointer, :pointer], :int
	
  # int iauTtut1(double tt1, double tt2, double dt, double *ut11, double *ut12)
  attach_function :iauTtut1, [:double, :double, :double, :pointer, :pointer], :int
	
  # int iauUt1tai(double ut11, double ut12, double dta, double *tai1, double *tai2)
  attach_function :iauUt1tai, [:double, :double, :double, :pointer, :pointer], :int
	
  # int iauUt1tt(double ut11, double ut12, double dt, double *tt1, double *tt2)
  attach_function :iauUt1tt, [:double, :double, :double, :pointer, :pointer], :int
	
  # int iauUt1utc(double ut11, double ut12, double dut1, double *utc1, double *utc2)
  attach_function :iauUt1utc, [:double, :double, :double, :pointer, :pointer], :int
	
  ## int iauUtctai(double utc1, double utc2, double *tai1, double *tai2)
  attach_function :iauUtctai, [:double, :double, :pointer, :pointer], :int
	
  ## int iauUtcut1(double utc1, double utc2, double dut1, double *ut11, double *ut12)
  attach_function :iauUtcut1, [:double, :double, :double, :pointer, :pointer], :int
	
end

