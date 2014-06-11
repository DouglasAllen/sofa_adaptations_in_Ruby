require 'date'
require 'ffi'

y,m,d = Time.now.utc.year, Time.now.utc.month, Time.now.utc.day

module Calendars
  extend FFI::Library
  ffi_lib "../../lib/libsofa_c.so"
  # i = iauCal2jd ( iy, im, id, &djm0, &djm );
  # d = iauEpb ( dj1, dj2 );
  # iauEpb2jd ( epb, &djm0, &djm );
  # d = iauEpj ( dj1, dj2 );
  # iauEpj2jd ( epj, &djm0, &djm );
  # i = iauJd2cal ( dj1, dj2, &iy, &im, &id, &fd );
  # i = iauJdcalf ( ndp, dj1, dj2, iymdf );
  attach_function :iauCal2jd, [:int, :int, :int, :pointer, :pointer ], :int
  attach_function :iauEpb, [:double, :double ], :double
  attach_function :iauEpb2jd, [ :double, :pointer, :pointer ], :void
  attach_function :iauEpj, [ :double, :double ], :double
  attach_function :iauEpj2jd, [ :double, :pointer, :pointer ], :void
  attach_function :iauJd2cal, [ :double, :double, :pointer, :pointer, :pointer, :pointer ], :int
  attach_function :iauJdcalf, [ :int, :double, :double, :pointer], :int
end
puts
puts "Gregorian Calendar to Julian Date"
puts "input = #{y}, #{m}, #{d}"
mp1 = FFI::MemoryPointer.new(:double, 8)
mp2 = FFI::MemoryPointer.new(:double, 8)
cal2jd = Calendars.iauCal2jd(y, m, d, mp1, mp2 )
puts "status = #{cal2jd}"
puts "jd 1 = #{mp1.get_double}", "jd 2 = #{mp2.get_double}"
puts "jd 1 + jd 2 = #{mp1.get_double + mp2.get_double}"

puts
puts "Julian Date to Besselian Epoch"
puts "input = #{2400000.5}, #{mp2.get_double}"
epb = Calendars.iauEpb(mp1.get_double, mp2.get_double)
puts "Besselian Epoch = #{epb}"

puts
puts "Besselian Epoch to Julian Date"
puts "input = #{epb}"
mp3 = FFI::MemoryPointer.new(:double, 8)
mp4 = FFI::MemoryPointer.new(:double, 8)
epb2jd = Calendars.iauEpb2jd( epb, mp3, mp4 )
puts "jd 1 = #{mp3.get_double}", "jd 2 = #{mp4.get_double}"
puts "jd 1 + jd 2 = #{mp3.get_double + mp4.get_double}"

puts
puts "Julian Date to Julian Epoch"
puts "input = #{2451545.0}, #{Date.today.jd - 2451545.0}"
epj = Calendars.iauEpj(2451545.0, Date.today.jd - 2451545.0)
puts "Julian Epoch = #{epj}"

puts
puts "Julian Epoch to Julian Date"
puts "input = #{epj}"
mp5 = FFI::MemoryPointer.new(:double, 8)
mp6 = FFI::MemoryPointer.new(:double, 8)
Calendars.iauEpj2jd( epj, mp5, mp6 )
puts "jd 1 = #{mp5.get_double}", "jd 2 = #{mp6.get_double}"
puts "jd 1 + jd 2 = #{mp5.get_double + mp6.get_double}"

puts
puts "Julian Date to Gregorian year, month, day, and fraction of a day."
puts "input = #{2400000.5}, #{mp2.get_double}"
mp7 = FFI::MemoryPointer.new(:int, 4)
mp8 = FFI::MemoryPointer.new(:int, 4)
mp9 = FFI::MemoryPointer.new(:int, 4)
mp10 = FFI::MemoryPointer.new(:double, 8)
jd2cal = Calendars.iauJd2cal( 2400000.5, mp2.get_double, mp7, mp8, mp9, mp10 )
puts "status = #{jd2cal}"
puts "year, month, day, fractional day #{mp7.get_int}, #{mp8.get_int}, #{mp9.get_int}, #{mp10.get_double}"

puts
puts "Julian Date to Gregorian Calendar formatted"
ajd = DateTime.now.to_time.utc.to_datetime.ajd.to_f
puts "input = 9, #{ajd}"
mp11 = FFI::MemoryPointer.new(:int, 4)
jdcalf = Calendars.iauJdcalf( 9, ajd, 0.0, mp11)
puts "status = #{jdcalf}"
ary = mp11.read_array_of_type(:int, :get_int, 4)
puts "returned array = #{ary}"
puts

module RCalendars
  attr_accessor :jd1, :jd2 
  def self.get_2jd(y, m, d, jd1, jd2 )  
    date = Date.new(y, m, d)
    @jd1 = (date.ajd - date.mjd).to_f
    @jd2 = date.mjd.to_f
    return 0    
  end
  def self.jd1 
    @jd1  
  end 
  def self.jd2 
    @jd2  
  end    
end


rcal = RCalendars.get_2jd(y, m, d, mp1, mp2 )
puts rcal
puts RCalendars.jd1, RCalendars.jd2

cal2jd = Calendars.iauCal2jd(y, m, d, mp1, mp2 )
puts cal2jd
puts mp1.get_double, mp2.get_double

require 'benchmark'

n = 500_000
Benchmark.bm do |x|
  x.report("jruby 1.7.11")  { n.times { RCalendars.get_2jd(y, m, d, mp1, mp2 ) } }
  x.report("jruby + ffi")  { n.times { Calendars.iauCal2jd(y, m, d, mp1, mp2 ) } }
end