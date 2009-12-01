use_orm :datamapper
use_test :rspec
use_template_engine :haml

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '5725354a5585f6c63013d67d98c23a910d83cbd7'  # required for cookie session store
  c[:session_id_key] = '_pwr_session_id' # cookie session id key, defaults to "_session_id"
  c[:kernel_dependencies] = false
end


Merb::BootLoader.before_app_loads do
  require 'lib/pauth'
  
  class String 
    def start_with?(little_string)
      match(/^#{Regexp.escape(little_string)}/)
    end
  end
end

Merb::BootLoader.after_app_loads do
  Merb::Plugins.config[:dm_pagination][:prev_label] = '&laquo; Poprzednie'
  Merb::Plugins.config[:dm_pagination][:next_label] = 'Następne &raquo;'
  
  PAuth.configure do |c|
    c.consumer_key = "qp9hqefpuh34f"
    c.consumer_secret = "p8h243p9g3g"
    c.host = "localhost"
    c.port = 80
    c.request_token_path = "/auth/server_php/index.php?action=request_token"
    c.access_token_path = "/auth/server_php/index.php?action=access_token"
    c.data_path = "/auth/server_php/index.php?action=data"
    c.login_path = "/auth/server_php/index.php?action=login"
  end
  
  Merb::Config[:ssh] = YAML.load(File.read(Merb.root / :config / 'ssh.yml')).to_mash
  
  require 'lib/uploader'
  Uploader.start!
end
