# use PathPrefix Middleware if :path_prefix is set in Merb::Config
if prefix = ::Merb::Config[:path_prefix]
  use Merb::Rack::PathPrefix, prefix
end

# preserving session for flash file upload
require 'lib/rack_flash_upload'  
use Merb::Rack::SetSessionCookieFromFlash, Merb::Config[:session_id_key]

# comment this out if you are running merb behind a load balancer
# that serves static files
use Merb::Rack::Static, Merb.dir_for(:public)

# this is our main merb application
run Merb::Rack::Application.new