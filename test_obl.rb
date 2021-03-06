require 'angles'
require 'time_scales'
require 'date'
require 'ffi'

time_now  = DateTime.now.to_time.utc.to_datetime
ajd_now   = time_now.ajd.to_f

puts "Time now = #{time_now}"
puts "AJD now  = #{ajd_now}"

module OBL
  extend FFI::Library
  ffi_lib "lib/libsofa_c.so"
	# double iauObl06(double date1, double date2)
	attach_function :iauObl06, [:double, :double], :double
end

def show_aa(ndp, type, pm, mp)
  Angles.iauA2af(ndp, type, pm, mp)
	aa = mp.read_array_of_type(:int, :get_int, 4)
	s = pm.read_string
	"= #{s}#{aa[0]}:#{aa[1]}:#{aa[2]} fs#{(aa[3] * 0.001).round(3)}"
end

# set up pointers and data
dut1   = -0.2860558
mp1    = FFI::MemoryPointer.new(:int, 4)
mp2    = FFI::MemoryPointer.new(:int, 4)
mp3    = FFI::MemoryPointer.new(:int, 4)
mp4    = FFI::MemoryPointer.new(:int, 4)
mp5    = FFI::MemoryPointer.new(:double, 8)
mp6    = FFI::MemoryPointer.new(:double, 8)
pm     = FFI::MemoryPointer.new(:char, 16)

ndp    = 3
string = "UTC"

# set up time scales 
status = Time_Scales.iauD2dtf(string, ndp, ajd_now, 0.0, mp1, mp2, mp3, mp4)
year   = mp1.get_int
month  = mp2.get_int
day    = mp3.get_int
ta     = mp4.read_array_of_type(:int, :get_int, 4)
hour, min, sec = ta[0], ta[1], (ta[2] + ta[3] * 0.001)
status = Time_Scales.iauDtf2d(string, year, month, day, hour, min, sec, mp5, mp6)
utc1, utc2  = mp5.get_double, mp6.get_double
status = Time_Scales.iauUtctai(utc1, utc2, mp5, mp6)
tai1, tai2 = mp5.get_double, mp6.get_double
status = Time_Scales.iauTaitt(tai1, tai2, mp5, mp6)
tt1, tt2 = mp5.get_double, mp6.get_double
status = Time_Scales.iauUtcut1(utc1, utc2, dut1, mp5, mp6)
ut11, ut12 = mp5.get_double, mp6.get_double

puts
puts "Mean obliquity of the ecliptic, IAU 2006 precession model."
moe = OBL.iauObl06(tt1, tt2)
p show_aa(ndp, moe, pm, mp1)