require 'ffi'

module MyLibrary
  extend FFI::Library
  ffi_lib "cal2jd.so"
  typedef :pointer, :djm0
  typedef :pointer, :djm
  attach_function :iauCal2jd, [:int, :int, :int, :pointer, :pointer], :int
end

djm0, djm = 0
puts MyLibrary.iauCal2jd(1992, 3, 21, *djm0, *djm)