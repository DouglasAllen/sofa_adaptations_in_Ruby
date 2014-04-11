# Wrap libc and use its malloc and free functions to allocate and free native memory.
module LibC
  extend FFI::Library
  # ffi_lib FFI::Library::LIBC
  ffi_lib libc
  # memory allocators
  attach_function :malloc, [:size_t], :pointer
  attach_function :calloc, [:size_t], :pointer
  attach_function :valloc, [:size_t], :pointer
  attach_function :realloc, [:pointer, :size_t], :pointer
  attach_function :free, [:pointer], :void
  
  # memory movers
  attach_function :memcpy, [:pointer, :pointer, :size_t], :pointer
  attach_function :bcopy, [:pointer, :pointer, :size_t], :void
  
end # module LibC

foo = "a ruby string"
bar = 3.14159
baz = [1, 2, 3, 4, 5]

buffer1 = LibC.malloc foo.size
buffer1.write_string foo

buffer2 = LibC.malloc bar.size
buffer2.write_float bar

# all of the array elements need to be the same type
# meaning you can't mix ints, floats, strings, etc.
buffer3 = LibC.malloc(baz.first.size * baz.size)
buffer3.write_array_of_int baz

