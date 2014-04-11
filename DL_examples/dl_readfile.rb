require 'dl/import'
require 'dl/types'

module Win32FileAPI
  extend DL::Importer
 
  dlload 'kernel32.dll', 'user32.dll'
 
  include DL::Win32Types
 
  # structs
  SECURITY_ATTRIBUTES = struct [
    'DWORD nLength',
    'PVOID lpSecurityDescriptor',
    'BOOL  bInheritHandle',
  ]
  typealias 'PSECURITY_ATTRIBUTES', 'SECURITY_ATTRIBUTES*'
 
  # FIXME these 3 are wrong
  # OL_OFFSET = struct [
    # 'DWORD Offset',
    # 'DWORD OffsetHigh',
  # ]
  # OL_UNION = union [
    # 'OL_OFFSET _offset',
    # 'PVOID Pointer',
  # ]
  OVERLAPPED = struct [
    # 'PDWORD Internal',
    # 'PDWORD InternalHigh',
    # 'OL_UNION _internal',
    # 'HANDLE hEvent',
    'PDWORD Internal',
    'PDWORD InternalHigh',
    'DWORD Offset',
    'DWORD OffsetHigh',
    #'OL_UNION _internal', # skip since Offsets are declared directly
    'HANDLE hEvent',
  ]
  typealias 'POVERLAPPED', 'OVERLAPPED*'
 
  # user32.dll functions
  extern 'int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT)', :stdcall
 
  # kernel32.dll functions
  extern 'HANDLE CreateFileA(LPCSTR, DWORD, DWORD, PSECURITY_ATTRIBUTES, DWORD, DWORD, HANDLE)', :stdcall
  # XXX cheat? - BOOL ReadFile(HANDLE, PVOID, DWORD, PDWORD, char*)
  #     really cheat? - BOOL ReadFile(HANDLE, PVOID, DWORD, PDWORD, PVOID)
  extern 'BOOL ReadFile(HANDLE, PVOID, DWORD, PDWORD, POVERLAPPED)', :stdcall
end
 
rv = Win32FileAPI::MessageBoxA(DL::NULL, 'Hello from Ruby 1.9 DL!', 'DL Info', 0x40 | 0x3)
puts rv