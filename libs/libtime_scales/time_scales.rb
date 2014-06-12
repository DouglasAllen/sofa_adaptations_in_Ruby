require 'date'
require 'ffi'

ajd = DateTime.now.to_time.utc.to_datetime.ajd.to_f
datetime = DateTime.jd(ajd + 0.5)
module Time_Scales
  extend FFI::Library
  ffi_lib '../../lib/libsofa_c.so'
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

dut1   = -0.2860558 # see http://maia.usno.navy.mil/search/search.html for current dut
mp1    = FFI::MemoryPointer.new(:int, 4)
mp2    = FFI::MemoryPointer.new(:int, 4)
mp3    = FFI::MemoryPointer.new(:int, 4)
mp4    = FFI::MemoryPointer.new(:int, 4)
mp5    = FFI::MemoryPointer.new(:double, 8)
mp6    = FFI::MemoryPointer.new(:double, 8)
mp7    = FFI::MemoryPointer.new(:double, 8)
mp8    = FFI::MemoryPointer.new(:char, 16)
ndp    = 3
string = "nil"

puts
puts "Time_Scales.iauD2dtf formats for output a 2-part Julian Date (or in the case of UTC a
      quasi-JD form that includes special provision for leap seconds)."
status = Time_Scales.iauD2dtf(string, ndp, ajd, 0.0, mp1, mp2, mp3, mp4)
puts "status = #{status}"
puts "input  = #{string}, #{ndp}, #{ajd}, 0.0, and pointers"
year   = mp1.get_int
month  = mp2.get_int
day    = mp3.get_int
ta     = mp4.read_array_of_type(:int, :get_int, 4)
puts "output = #{year}, #{month}, #{day}, #{ta}"

puts
puts "Encode date and time fields into 2-part Julian Date (or in the case of UTC a quasi-JD form that 
      includes special provision for leap seconds)."
hour, min, sec = ta[0], ta[1], (ta[2] + ta[3] * 0.001)
status = Time_Scales.iauDtf2d(string, year, month, day, hour, min, sec, mp5, mp6)
puts "input  = #{string}, #{year}, #{month}, #{day}, #{hour}, #{min}, #{sec}"
utc1, utc2  = mp5.get_double, mp6.get_double
puts "output = #{utc1}, #{utc2}"
delta_ta = 32.184
puts utc2 + delta_ta

puts
puts "Time_Scales.iauUtctai transforms Coordinated Universal Time, UTC, to International Atomic Time, TAI."
status = Time_Scales.iauUtctai(utc1, utc2, mp5, mp6)
puts "input  = #{utc1}, #{utc2}"
tai1, tai2 = mp5.get_double, mp6.get_double
puts "output = #{tai1}, #{tai2}"

puts 
puts "Time_Scales.iauDat for a given UTC date, calculate delta(AT) = TAI-UTC."
df     = utc2
status = Time_Scales.iauDat(year, month, day, df, mp1)
puts "status = #{status}"
puts "input  = #{year}, #{month}, #{day}, #{df}"
dat    = mp1.get_double
puts "output = #{dat}, #{dat / 86400.0}"

puts
puts "Time_Scales.iauTaitt transforms International Atomic Time, TAI, to Terrestrial Time, TT."
status = Time_Scales.iauTaitt(tai1, tai2, mp5, mp6)
puts "status = #{status}"
puts "input  = #{tai1}, #{tai2}"
tt1, tt2 = mp5.get_double, mp6.get_double
puts "output = #{tt1}, #{tt2}"

puts
puts "Time_Scales.iauTttai transforms  Terrestrial Time, TT, to International Atomic Time, TAI."
status = Time_Scales.iauTttai(tt1, tt2, mp5, mp6)
puts "status = #{status}"
puts "input  = #{tt1}, #{tt2}"
tai1   = mp5.get_double
tai2   = mp6.get_double
puts "output = #{tai1}, #{tai2}"

puts
puts "Time_Scales.iauTaiutc transforms  International Atomic Time, TAI, to Coordinated Universal Time, UTC." 
status = Time_Scales.iauTaiutc(tai1, tai2, mp5, mp6)
puts "status = #{status}"
puts "input  = #{tai1}, #{tai2}"
utc1   = mp5.get_double
utc2   = mp6.get_double
puts "output = #{utc1}, #{utc2}"

puts
puts "Time_Scales.iauTaiut1 transforms International Atomic Time, TAI, to Universal Time, UT1."
ut1 =  dut1 / 86400.0 + utc2 
dta = ut1 - tai2
status = Time_Scales.iauTaiut1(tai1, tai2, dta, mp5, mp6)
ut11, ut12 = mp5.get_double, mp6.get_double
puts "input  = #{tai1}, #{tai2}"
puts "output = #{ut11}, #{ut12}"

puts
puts "delta T = 32.184 + (TAI-UTC) - (UT1-UTC)"
puts "delta T = 32.184s + #{dat}s - #{-0.2860558}s"
puts "delta T = #{32.184 + dat - -0.2860558}"

puts
puts "Time_Scales.iauUtcut1 transforms Coordinated Universal Time, UTC, to Universal Time, UT1." 
status = Time_Scales.iauUtcut1(utc1, utc2, dut1, mp5, mp6) 
puts "input  = #{utc1}, #{utc2}"
puts "output = #{ut11}, #{ut12}"
    
puts
puts "Time_Scales.iauD2tf Decompose days to hours, minutes, seconds, fraction."
days = 0.333
void_status = Time_Scales.iauD2tf(ndp, days, mp8, mp1)
ihmsf = mp1.read_array_of_type(:int, :get_int, 4)
sign  = mp8.read_string
puts "#{sign}#{ihmsf}"

puts
puts "Time_Scales.iauTttdb transforms Terrestrial Time, TT, to Barycentric Dynamical Time, TDB."
status = Time_Scales.iauTttdb()
#iauDtdb






