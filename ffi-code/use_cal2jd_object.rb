require 'dl'
require 'dl/import'
require 'dl/struct'
 
  module LibCalendars
          extend DL::Importer
          dlload 'cal2jd.so'
          # extern 'int iauCal2jd(int, int, int, double *, double *)'
          PrototypeData = struct [
            "int  year", 
            "int  month",
            "int  day",
            "double *djm0",
            "double *djm",
          ]
          # extern "int  iauCal2jd(int, int, int, &djm0, &djm)"
          extern 'int iauCal2jd(int, int, int, double *, double *)'          
  end
  
  y = 1996
  m = 2
  d = 10
  
  cal = LibCalendars.iauCal2jd(y, m, d, "a*", "b*")
  puts LibCalendars::PrototypeData.methods
  
  
  