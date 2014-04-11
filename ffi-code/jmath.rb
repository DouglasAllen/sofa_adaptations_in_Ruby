require 'ffi'

class FFIMath
  extend FFI::Library

  # load our custom C library and attach
  # FFI functions to our Ruby runtime
  # ffi_lib "/root/ffi/libsimplemath.so"
  ffi_lib "libsimplemath.so"

  functions = [
    [:power, [:double, :double], :double],
    [:square_root, [:double], :double],
    [:ffi_factorial, [:int], :long]
  ]

  functions.each do |func|
    begin
      attach_function(*func)
    rescue Object => e
      puts "Could not attach #{func}, #{e.message}"
    end
  end

end

puts FFIMath.power(3,5)          # => 243.0
puts FFIMath.square_root(81)    # => 9.0
puts FFIMath.ffi_factorial(10)    # => 3628800

####

class RubyMath
  def ruby_pow(x,y)
    x**y
  end

  def ruby_sqrt(x)
    Math.sqrt(x)
  end

  def factorial(n)
    f = 1
    n.downto(2) { |x| f *= x }
    f
  end
end

r = RubyMath.new
puts r.ruby_pow(3,5)  # => 243.0
puts r.ruby_sqrt(81)  # => 9.0
puts r.factorial(10)  # => 3628800

require 'benchmark'

n = 500000
Benchmark.bm do |x|
  x.report("jruby 1.1.6")  { n.times { r.ruby_pow(3,5); r.ruby_sqrt(81); r.factorial(10) } }
  x.report("jruby + ffi")  { n.times { FFIMath.power(3,5); FFIMath.square_root(81); FFIMath.ffi_factorial(15); } }
end