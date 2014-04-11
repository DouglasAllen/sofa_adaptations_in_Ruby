require 'dl/import'

 # module Curl
   # extend DL::Importer
   # dlload "libcurl.dll" 
   # extern "char *curl_version()" 
 # end

 # puts Curl.curl_version
 
 require 'dl/struct'

 module Curl
   extend DL::Importer
   dlload "libcurl.dll" 
   # extern "char *curl_version()" 
   VersionInfoData = struct [
     "int  age",
     "char *version",
     "uint version_num",
     "char *host",
     "int  features",
     "char *ssl_version",
     "long ssl_version_num",
     "char *libz_version",
     "char **protocols" 
   ]
   extern "void *curl_version_info(int)" 
 end

 ver = Curl::VersionInfoData.new( Curl.curl_version_info( 0 ) )
 puts ver.class
 puts "Curl version: #{ver::version()}"#public_methods(false)}"
 # puts "Built on " + ver.host.to_s
 # puts "Libz version: " + ver.libz_version.to_s