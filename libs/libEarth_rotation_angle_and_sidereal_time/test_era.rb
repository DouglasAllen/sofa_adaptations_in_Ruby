require 'date'
require 'ffi'

y,m,d = Time.now.utc.year, Time.now.utc.month, Time.now.utc.day
time_now  = DateTime.now.to_time.utc.to_datetime
# ajd   = time_now.ajd.to_f
ajd   = DateTime.new(1954, 12, 15, 14, 0, 0).to_time.utc.to_datetime.ajd.to_f

module ERA
  extend FFI::Library
  ffi_lib "../../lib/libsofa_c.so"
  
  # double iauEra00(double dj1, double dj2)
  attach_function :iauEra00, [:double, :double], :double
  
  # double iauGmst00(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst00, [:double, :double, :double, :double], :double
  
  # double iauGmst06(double uta, double utb, double tta, double ttb)
  attach_function :iauGmst06, [:double, :double, :double, :double], :double 
  
  # double iauGmst82(double dj1, double dj2)
  attach_function :iauGmst82, [:double, :double], :double
  
  # double iauGst00a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst00a, [:double, :double, :double, :double], :double
  
  # double iauGst00b(double uta, double utb)
  attach_function :iauGst00b, [:double, :double], :double
  
  # double iauGst06(double uta, double utb, double tta, double ttb, double rnpb[3][3])
  attach_function :iauGst06, [:double, :double, :double, :double, :double], :double
  
  # double iauGst06a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst06a, [:double, :double, :double, :double], :double 
  
  # double iauGst94(double uta, double utb)
  attach_function :iauGst94, [:double, :double], :double  
  
  # void iauA2tf(int ndp, double angle, char *sign, int ihmsf[4])
  attach_function :iauA2tf, [:int, :double, :pointer, :pointer], :void
end
module Time_Scales
  extend FFI::Library
  ffi_lib '../../lib/libsofa_c.so'
  
  attach_function :iauD2dtf, [:string, :int, :double, :double, :pointer, :pointer, :pointer, :pointer], :int
  
  attach_function :iauDtf2d, [:string, :int, :int, :int, :int, :int, :double, :pointer, :pointer], :int
  
  attach_function :iauUtctai, [:double, :double, :pointer, :pointer], :int
  
  attach_function :iauTaitt, [:double, :double, :pointer, :pointer], :int
  
  attach_function :iauUtcut1, [:double, :double, :double, :pointer, :pointer], :int
end

# set up pointers and data
dut1   = -0.2860558
mp1    = FFI::MemoryPointer.new(:int, 4)
mp2    = FFI::MemoryPointer.new(:int, 4)
mp3    = FFI::MemoryPointer.new(:int, 4)
mp4    = FFI::MemoryPointer.new(:int, 4)
mp5    = FFI::MemoryPointer.new(:double, 8)
mp6    = FFI::MemoryPointer.new(:double, 8)
sign_p = FFI::MemoryPointer.new(:char, 16)

ndp    = 3
string = "UTC"

# set up time scales 
status = Time_Scales.iauD2dtf(string, ndp, ajd, 0.0, mp1, mp2, mp3, mp4)
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

# show sign and right ascension time
def show_ta(ndp, type, sign_p, mp1)
  ERA.iauA2tf(ndp, type, sign_p, mp1)
  ta = mp1.read_array_of_type(:int, :get_int, 4)
  s = sign_p.read_string
  "= #{s}#{ta[0]}:#{ta[1]}:#{ta[2]} fs#{(ta[3] * 0.001).round(3)}"
end

puts
puts "Greenwich mean sidereal time (model consistent with IAU 2000 resolutions)."
gmst = ERA.iauGmst00(ut11, ut12, tt1, tt2)
p show_ta(ndp, gmst, sign_p, mp1)

puts
puts "Greenwich mean sidereal time (model consistent with IAU 2006 precession)."
gmst = ERA.iauGmst06(ut11, ut12, tt1, tt2)
p show_ta(ndp, gmst, sign_p, mp1)  

puts
puts "Universal Time to Greenwich mean sidereal time (IAU 1982 model)."
gmst = ERA.iauGmst82(utc1, utc2)
p show_ta(ndp, gmst, sign_p, mp1) 

puts
puts "Greenwich apparent sidereal time (consistent with IAU 2000 resolutions)."
gst = ERA.iauGst00a(ut11, ut12, tt1, tt2)
p show_ta(ndp, gst, sign_p, mp1) 

puts
puts "Greenwich apparent sidereal time (consistent with IAU 2000
resolutions but using the truncated nutation model IAU 2000B)."
gst = ERA.iauGst00b(ut11, ut12)
p show_ta(ndp, gst, sign_p, mp1) 
 
# not ready
# puts
# puts "Greenwich apparent sidereal time, IAU 2006, given the NPB matrix."
# something = 0
# gst = ERA.iauGst06(ut11, ut12, tt1, tt2, something)
# show_ta(ndp, gst, sign_p, mp1)

puts
puts "Greenwich apparent sidereal time (consistent with IAU 2000 and 2006 resolutions)."
gst = ERA.iauGst06a(ut11, ut12, tt1, tt2)
p show_ta(ndp, gst, sign_p, mp1)

puts
puts "Greenwich apparent sidereal time (consistent with IAU 1982/94 resolutions)."
gmst = ERA.iauGst94(utc1, utc2)
p show_ta(ndp, gmst, sign_p, mp1)  

puts
puts "Earth rotation angle (IAU 2000 model)."
era = ERA.iauEra00(tt1, tt2)
p show_ta(ndp, era, sign_p, mp1)

puts
lst = era - 1.548984947
puts "My local sidereal time from ERA #{show_ta(ndp, lst, sign_p, mp1)}" 

# loop do
  # ajd   = DateTime.now.to_time.utc.to_datetime.ajd.to_f
  # status = Time_Scales.iauD2dtf(string, ndp, ajd, 0.0, mp1, mp2, mp3, mp4)
	# year   = mp1.get_int
	# month  = mp2.get_int
	# day    = mp3.get_int
	# ta     = mp4.read_array_of_type(:int, :get_int, 4)
	# hour, min, sec = ta[0], ta[1], (ta[2] + ta[3] * 0.001)
	# status = Time_Scales.iauDtf2d(string, year, month, day, hour, min, sec, mp5, mp6)
	# utc1, utc2  = mp5.get_double, mp6.get_double
	# status = Time_Scales.iauUtctai(utc1, utc2, mp5, mp6)
	# tai1, tai2 = mp5.get_double, mp6.get_double
	# status = Time_Scales.iauTaitt(tai1, tai2, mp5, mp6)
	# tt1, tt2 = mp5.get_double, mp6.get_double
	# era = ERA.iauEra00(tt1, tt2)
  # lst = era - 1.548984947
  # p show_ta(ndp, lst, sign_p, mp1)
# end