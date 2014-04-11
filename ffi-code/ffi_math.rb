require 'ffi'

class FFIMath
  extend FFI::Library

  # load our custom C library and attach
  # FFI functions to our Ruby runtime
  ffi_lib "libsimplemath.so"

  functions = [
    # method # parameters        # return
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

puts FFIMath.power(3,5)           # => 243.0
puts FFIMath.square_root(81)      # => 9.0
puts FFIMath.ffi_factorial(10)    # => 3628800