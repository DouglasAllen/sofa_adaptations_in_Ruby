require 'date'
require 'ffi'

y,m,d = Time.now.utc.year, Time.now.utc.month, Time.now.utc.day
ajd = DateTime.now.to_time.utc.to_datetime.ajd.to_f
fc = (ajd - 2451545.0) / 36525.0
module FundamentalArguments
  extend FFI::Library
  ffi_lib "fal03.so"
  attach_function :iauFal03, [ :double ], :double
  ffi_lib "falp03.so"
  attach_function :iauFalp03, [ :double ], :double
  ffi_lib "faf03.so"
  attach_function :iauFaf03, [ :double ], :double
  ffi_lib "fad03.so"
  attach_function :iauFad03, [ :double ], :double
  ffi_lib "faom03.so"
  attach_function :iauFaom03, [ :double ], :double
end

puts
puts "Fundamental argument, IERS Conventions (2003):
      mean anomaly of the Moon."
ma_moon = FundamentalArguments.iauFal03(fc)
puts "input  = #{fc} fractional centuries"
puts "output = #{ma_moon} radians"
puts "output = #{ma_moon * 180.0 / Math::PI} degrees"
ma_moon = [-0.00024470, 0.051635, 31.8792, 1717915923.2178, 485868.249036].inject(0.0) {|p, a| p * fc + a}
puts ma_moon / 3600.0 % 360

puts
puts "Fundamental argument, IERS Conventions (2003):
      mean anomaly of the Sun."
ma_sun = FundamentalArguments.iauFalp03(fc)
puts "input  = #{fc} fractional centuries"
puts "output = #{ma_sun} radians"
puts "output = #{ma_sun * 180.0 / Math::PI} degrees"
ma_sun  = [-0.00001149, 0.000136, -0.5532, 129596581.0481, 1287104.79305].inject(0.0) {|p, a| p * fc + a} 	
puts ma_sun / 3600.0 % 360

puts
puts "Fundamental argument, IERS Conventions (2003):
      mean longitude of the Moon minus mean longitude of the ascending
      node."
md_moon = FundamentalArguments.iauFaf03(fc)
puts "input  = #{fc} fractional centuries"
puts "output = #{md_moon} radians"
puts "output = #{md_moon * 180.0 / Math::PI} degrees"
md_moon = [0.00000417, -0.001037, -12.7512, 1739527262.8478, 335779.526232].inject(0.0) {|p, a| p * fc + a}
puts md_moon / 3600.0 % 360

puts
puts "Fundamental argument, IERS Conventions (2003):
      mean elongation of the Moon from the Sun."
me_moon = FundamentalArguments.iauFad03(fc)
puts "input  = #{fc} fractional centuries"
puts "output = #{me_moon} radians"
puts "output = #{me_moon * 180.0 / Math::PI} degrees"
me_moon = [-0.00003169, 0.006593, -6.3706, 1602961601.2090, 1072260.703692].inject(0.0) {|p, a| p * fc + a} 
puts me_moon / 3600.0 % 360

puts
puts "Fundamental argument, IERS Conventions (2003):
      mean longitude of the Moon's ascending node."
omega = FundamentalArguments.iauFaom03(fc)
puts "input  = #{fc} fractional centuries"
puts "output = #{omega} radians"
puts "output = #{omega * 180.0 / Math::PI} degrees"		   
omega   = [-0.00005939, 0.007702, 7.4722, -6962890.5431, 450160.398036].inject(0.0) {|p, a| p * fc + a}
puts omega / 3600.0 

require 'benchmark'

n = 50_000
Benchmark.bm do |x|
  x.report("jruby 1.7.11")  { n.times { [-0.00024470, 0.051635, 31.8792, 1717915923.2178, 485868.249036].inject(0.0) {|p, a| p * fc + a} } }
  x.report("jruby + ffi")  { n.times { FundamentalArguments.iauFal03(fc) } }
  x.report("jruby 1.7.11")  { n.times { [-0.00001149, 0.000136, -0.5532, 129596581.0481, 1287104.79305].inject(0.0) {|p, a| p * fc + a} } }
  x.report("jruby + ffi")  { n.times { FundamentalArguments.iauFalp03(fc) } }
  x.report("jruby 1.7.11")  { n.times { [0.00000417, -0.001037, -12.7512, 1739527262.8478, 335779.526232].inject(0.0) {|p, a| p * fc + a} } }
  x.report("jruby + ffi")  { n.times { FundamentalArguments.iauFaf03(fc) } }
  x.report("jruby 1.7.11")  { n.times { [-0.00003169, 0.006593, -6.3706, 1602961601.2090, 1072260.703692].inject(0.0) {|p, a| p * fc + a} } }
  x.report("jruby + ffi")  { n.times { FundamentalArguments.iauFad03(fc) } }
  x.report("jruby 1.7.11")  { n.times { [-0.00005939, 0.007702, 7.4722, -6962890.5431, 450160.398036].inject(0.0) {|p, a| p * fc + a} } }
  x.report("jruby + ffi")  { n.times { FundamentalArguments.iauFaom03(fc) } }
end           