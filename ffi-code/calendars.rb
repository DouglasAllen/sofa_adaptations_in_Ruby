require 'date'
require 'ffi'

y,m,d = Date.today.year, Date.today.month, Date.today.day
module Calendars
  extend FFI::Library

  ffi_lib 'cal2jd.so'
  
  attach_function :iauCal2jd, [:int, :int, :int, :pointer, :pointer ], :int

end

mp1 = FFI::MemoryPointer.new(:double, 8)
mp2 = FFI::MemoryPointer.new(:double, 8)
cal = Calendars.iauCal2jd(y, m, d, mp1, mp2 )
puts cal

puts mp1.get_double, mp2.get_double

class RCalendars
  def get_2jd(y, m, d, mp1, mp2 )  
    date = Date.parse("#{y}-#{m}-#{d}")  
  end  
end

r = RCalendars.new
puts r.get_2jd(y, m, d, mp1, mp2 )

require 'benchmark'

n = 500000
Benchmark.bm do |x|
  x.report("jruby 1.1.7")  { n.times { r.get_2jd(y, m, d, mp1, mp2 ) } }
  x.report("jruby + ffi")  { n.times { Calendars.iauCal2jd(2014, 4, 6, mp1, mp2 ) } }
end