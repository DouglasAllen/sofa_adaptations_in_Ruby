require 'ffi'

# module CodeGen                   # Ruby wrapper  (your choice)
  # extend FFI::Library
  # ffi_lib 'c'          # DLL name  (given)
  # attach_function(
    # :create_code,                # method name  (your choice)
    # :CreateCodeShort3,           # DLL function name (given)
                                   #specify C param / return value types
    # [ :int, :string, :string, :uint, :ushort, :ushort], :string  
    # )                       
# end

# ret_str = CodeGen.create_code(3, "foo", "bar", 0,0,0)

# puts ret_str

require 'ffi'

module Win32
   extend FFI::Library
   ffi_lib 'user32'
   attach_function( 
                    :messageBox, 
                      :MessageBoxA,
                        [ :pointer, :string, :string, :long ], 
                        :int
                  )
end

rc = Win32.messageBox(nil, "Hello Ruby user!", "FFI is easy", 0x40)

puts rc