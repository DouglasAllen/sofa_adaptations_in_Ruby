# FFI example of calling native getpid function

require 'ffi'

module GetPid
  extend FFI::Library
  ffi_lib "msvcrt"
  attach_function :_getpid, [], :uint
  attach_function :getenv, [], :uint
  attach_function :_beginthread, [], :uint
  attach_function :_endthread, [], :uint
end

# GetPid._beginthread # crashes.
GetPid.getenv

puts GetPid._getpid

# GetPid._endthread


