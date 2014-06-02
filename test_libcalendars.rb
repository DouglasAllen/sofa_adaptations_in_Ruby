require 'date'
require 'ffi'

y,m,d = Date.today.year, Date.today.month, Date.today.day
module Calendars
  extend FFI::Library
  ffi_lib "libcalendars.so"
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

puts 1
mp1 = FFI::MemoryPointer.new(:double, 8)
mp2 = FFI::MemoryPointer.new(:double, 8)
p cal2jd = Calendars.iauCal2jd(y, m, d, mp1, mp2 )
puts mp1.get_double, mp2.get_double

puts 2
p epb = Calendars.iauEpb(mp1.get_double, mp2.get_double)

puts 3
mp3 = FFI::MemoryPointer.new(:double, 8)
mp4 = FFI::MemoryPointer.new(:double, 8)
p Calendars.iauEpb2jd( epb, mp3, mp4 )
puts mp3.get_double, mp4.get_double

puts 4
p epj = Calendars.iauEpj(mp3.get_double, mp4.get_double)

puts 5
mp5 = FFI::MemoryPointer.new(:double, 8)
mp6 = FFI::MemoryPointer.new(:double, 8)
p Calendars.iauEpj2jd( epj, mp5, mp6 )
puts mp5.get_double, mp6.get_double

puts 6
mp7 = FFI::MemoryPointer.new(:int, 4)
mp8 = FFI::MemoryPointer.new(:int, 4)
mp9 = FFI::MemoryPointer.new(:int, 4)
mp10 = FFI::MemoryPointer.new(:double, 8)
p jd2cal = Calendars.iauJd2cal( mp5.get_double, mp6.get_double, mp7, mp8, mp9, mp10 )
puts mp7.get_int, mp8.get_int, mp9.get_int, mp10.get_double

puts 7
mp11 = FFI::MemoryPointer.new(:int, 4)
p jdcalf = Calendars.iauJdcalf( 6, mp5.get_double, mp6.get_double, mp11)
p ary = mp11.read_array_of_type(:int, :get_int, 4)

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


# rcal = RCalendars.get_2jd(y, m, d, nil, nil )
# puts rcal
# puts RCalendars.jd1, RCalendars.jd2

# require 'benchmark'

# n = 500_000
# Benchmark.bm do |x|
  # x.report("jruby 1.7.11")  { n.times { RCalendars.get_2jd(y, m, d, mp1, mp2 ) } }
  # x.report("jruby + ffi")  { n.times { Calendars.iauCal2jd(2014, 4, 6, mp1, mp2 ) } }
# end