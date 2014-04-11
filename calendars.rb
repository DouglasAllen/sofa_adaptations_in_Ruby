require 'date'
require 'ffi'

y,m,d = Date.today.year, Date.today.month, Date.today.day
module Calendars
  extend FFI::Library

  ffi_lib 'cal2jd.dll'
  
  attach_function :iauCal2jd, [:int, :int, :int, :pointer, :pointer ], :int

end

mp1 = FFI::MemoryPointer.new(:double, 8)
mp2 = FFI::MemoryPointer.new(:double, 8)
cal = Calendars.iauCal2jd(y, m, d, mp1, mp2 )
puts cal

puts mp1.get_double, mp2.get_double

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


rcal = RCalendars.get_2jd(y, m, d, nil, nil )
puts rcal
puts RCalendars.jd1, RCalendars.jd2

require 'benchmark'

n = 500_000
Benchmark.bm do |x|
  x.report("jruby 1.7.11")  { n.times { RCalendars.get_2jd(y, m, d, mp1, mp2 ) } }
  x.report("jruby + ffi")  { n.times { Calendars.iauCal2jd(2014, 4, 6, mp1, mp2 ) } }
end