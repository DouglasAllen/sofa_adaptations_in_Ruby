require 'date'
require 'ffi'

module Time_Scales
  extend FFI::Library

  ffi_lib 'tttai.so'
  # iauTttai ( tt1, tt2, &tai1, &tai2 );
  
  attach_function :iauTttai, [:double, :double, :pointer, :pointer ], :int

end

tt1 = DateTime.now.ajd.floor.to_f
tt2 = DateTime.now.day_fraction.to_f
mp1 = FFI::MemoryPointer.new(:double, 8)
mp2 = FFI::MemoryPointer.new(:double, 8)
ts  = Time_Scales.iauTttai( tt1, tt2, mp1, mp2 )
puts
puts "Time scale transformation:\n  Terrestrial Time, TT, to International Atomic Time, TAI"
puts "status             = #{ts}"
puts "input              = #{tt1}, #{tt2.to_f}"
puts "output             = #{mp1.get_double}, #{mp2.get_double}"
puts "difference         = #{tt2.to_f - mp2.get_double}"
puts "difference hours   = #{(tt2.to_f - mp2.get_double) * 24.0}"
puts "difference minutes = #{(tt2.to_f - mp2.get_double) * 1440.0}"
puts "difference seconds = #{(tt2.to_f - mp2.get_double) * 86400.0}"
puts