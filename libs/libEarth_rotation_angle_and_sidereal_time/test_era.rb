require 'date'
require 'ffi'

y,m,d = Time.now.utc.year, Time.now.utc.month, Time.now.utc.day
ajd   = DateTime.now.to_time.utc.to_datetime.ajd.to_f
time  = DateTime.now.to_time.utc.to_datetime
module ERA
  extend FFI::Library
  ffi_lib "../../lib/libsofa_c.so"
  # double iauEra00(double dj1, double dj2)
  attach_function :iauEra00, [:double, :double], :double
  # double iauGst00a(double uta, double utb, double tta, double ttb)
  attach_function :iauGst00a, [:double, :double, :double, :double], :double
  # double iauGmst82(double dj1, double dj2)
  attach_function :iauGmst82, [:double, :double], :double
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

dut1   = -0.2860558
mp1    = FFI::MemoryPointer.new(:int, 4)
mp2    = FFI::MemoryPointer.new(:int, 4)
mp3    = FFI::MemoryPointer.new(:int, 4)
mp4    = FFI::MemoryPointer.new(:int, 4)
mp5    = FFI::MemoryPointer.new(:double, 8)
mp6    = FFI::MemoryPointer.new(:double, 8)

ndp    = 3
string = "UTC"
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

puts
puts "Earth rotation angle (IAU 2000 model)."
era = ERA.iauEra00(tt1, tt2)
puts "at #{time} the ERA was #{era} radians"
puts "at #{time} the ERA was #{era * 180.0 / Math::PI} degrees"
puts "at #{time} the ERA was #{era * 180.0 / Math::PI / 15.0} hours"

puts
puts "Greenwich apparent sidereal time (consistent with IAU 2000 resolutions)."
gst = ERA.iauGst00a(ut11, ut12, tt1, tt2)
puts "at #{time} the GST was #{gst} radians"
puts "at #{time} the GST was #{gst * 180.0 / Math::PI} degrees"
puts "at #{time} the GST was #{gst * 180.0 / Math::PI / 15.0} hours"

puts
puts "Universal Time to Greenwich mean sidereal time (IAU 1982 model)."
gmst = ERA.iauGmst82(utc1, utc2)
puts "at #{time} the GMST was #{gmst} radians"
puts "at #{time} the GMST was #{gmst * 180.0 / Math::PI} degrees"
puts "at #{time} the GMST was #{gmst * 180.0 / Math::PI / 15.0} hours"

puts era - gst