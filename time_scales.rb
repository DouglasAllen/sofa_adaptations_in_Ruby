
require 'ffi'

module Time_Scales

  extend FFI::Library
  ffi_lib 'lib/libsofa_c.so'	
	
	# D2DTF format 2−part JD for output
  # int iauD2dtf(const char *scale, int ndp, double d1, double d2, int *iy, int *im, int *id, int ihmsf[4])
  attach_function :iauD2dtf, [:string, :int, :double, :double, :pointer, :pointer, :pointer, :pointer], :int
	
	# D2TF Decompose days to hours, minutes, seconds, fraction
  # void iauD2tf(int ndp, double days, char *sign, int ihmsf[4])
  attach_function :iauD2tf, [:int, :double, :pointer, :pointer], :void
	
	# DAT Delta(AT) (=TAI−UTC) for a given UTC date
  # int iauDat(int iy, int im, int id, double fd, double *deltat )
  attach_function :iauDat, [:int, :int, :int, :double, :pointer], :int
	
	# DTDB TDB−TT
  # double iauDtdb(double date1, double date2, double ut, double elong, double u, double v)
  attach_function :iauDtdb, [:double, :double, :double, :double, :double, :double], :double
	
	# DTF2D encode time and date fields into 2−part JD
  # int iauDtf2d(const char *scale, int iy, int im, int id, int ihr, int imn, double sec, double *d1, double *d2)
  attach_function :iauDtf2d, [:string, :int, :int, :int, :int, :int, :double, :pointer, :pointer], :int
  
	# TAITT TAI to TT
  # int iauTaitt(double tai1, double tai2, double *tt1, double *tt2)
  attach_function :iauTaitt, [:double, :double, :pointer, :pointer], :int
	
	# TAIUT1 TAI to UT1
  # int iauTaiut1(double tai1, double tai2, double dta, double *ut11, double *ut12)
  attach_function :iauTaiut1, [:double, :double, :double, :pointer, :pointer], :int
	
	# TAIUTC TAI to UTC
  # int iauTaiutc(double tai1, double tai2, double *utc1, double *utc2)
  attach_function :iauTaiutc, [:double, :double, :pointer, :pointer], :int
	
	# TCBTDB TCB to TDB
  # int iauTcbtdb(double tcb1, double tcb2, double *tdb1, double *tdb2)
  attach_function :iauTcbtdb, [:double, :double, :pointer, :pointer], :int
	
	# TCGTT TCG to TT
  # int iauTcgtt(double tcg1, double tcg2, double *tt1, double *tt2)
  attach_function :iauTcgtt, [:double, :double, :pointer, :pointer], :int
	
	# TDBTCB TDB to TCB
  # int iauTdbtcb(double tdb1, double tdb2, double *tcb1, double *tcb2)
  attach_function :iauTdbtcb, [:double, :double, :pointer, :pointer], :int
	
	# TDBTT TDB to TT
  # int iauTdbtt(double tdb1, double tdb2, double dtr, double *tt1, double *tt2 )
  attach_function :iauTdbtt, [:double, :double, :double, :pointer, :pointer], :int
	
	# TTTAI TT to TAI
  # int iauTttai(double tt1, double tt2, double *tai1, double *tai2)  
  attach_function :iauTttai, [:double, :double, :pointer, :pointer ], :int 
	
	# TTTCG TT to TCG
  # int iauTttcg(double tt1, double tt2, double *tcg1, double *tcg2)
  attach_function :iauTttcg, [:double, :double, :pointer, :pointer], :int
	
	# TTTDB TT to TDB
  # int iauTttdb(double tt1, double tt2, double dtr, double *tdb1, double *tdb2)
  attach_function :iauTttdb, [:double, :double, :double, :pointer, :pointer], :int
	
	# TTUT1 TT to UT1
  # int iauTtut1(double tt1, double tt2, double dt, double *ut11, double *ut12)
  attach_function :iauTtut1, [:double, :double, :double, :pointer, :pointer], :int
	
	# UT1TAI UT1 to TAI
  # int iauUt1tai(double ut11, double ut12, double dta, double *tai1, double *tai2)
  attach_function :iauUt1tai, [:double, :double, :double, :pointer, :pointer], :int
	
	# UT1TT UT1 to TT
  # int iauUt1tt(double ut11, double ut12, double dt, double *tt1, double *tt2)
  attach_function :iauUt1tt, [:double, :double, :double, :pointer, :pointer], :int
	
	# UT1UTC UT1 to UTC
  # int iauUt1utc(double ut11, double ut12, double dut1, double *utc1, double *utc2)
  attach_function :iauUt1utc, [:double, :double, :double, :pointer, :pointer], :int
	
	# UTCTAI UTC to TAI
  # int iauUtctai(double utc1, double utc2, double *tai1, double *tai2)
  attach_function :iauUtctai, [:double, :double, :pointer, :pointer], :int
	
	# UTCUT1 UTC to UT1
  # int iauUtcut1(double utc1, double utc2, double dut1, double *ut11, double *ut12)
  attach_function :iauUtcut1, [:double, :double, :double, :pointer, :pointer], :int
	
end

