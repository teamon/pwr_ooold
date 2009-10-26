# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
 
use_orm :datamapper
use_test :rspec
use_template_engine :haml
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '5725354a5585f6c63013d67d98c23a910d83cbd7'  # required for cookie session store
  c[:session_id_key] = '_pwr_session_id' # cookie session id key, defaults to "_session_id"
end


 
Merb::BootLoader.before_app_loads do
  require 'lib/pauth'  
end
 
Merb::BootLoader.after_app_loads do
  Merb::Plugins.config[:dm_pagination][:prev_label] = '&laquo; Poprzednie'
  Merb::Plugins.config[:dm_pagination][:next_label] = 'Następne &raquo;'
end
