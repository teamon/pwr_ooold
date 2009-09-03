require "rubygems"

# Add the local gems dir if found within the app root; any dependencies loaded
# hereafter will try to load from the local gems before loading system gems.
if (local_gem_dir = File.join(File.dirname(__FILE__), '..', 'gems')) && $BUNDLE.nil?
  $BUNDLE = true; Gem.clear_paths; Gem.path.unshift(local_gem_dir)
end

require "merb-core"
require "spec" # Satisfies Autotest and anyone else not using the Rake tasks

# this loads all plugins required in your init file so don't add them
# here again, Merb will do it for you
Merb.start_environment(:testing => true, :adapter => 'runner', :environment => ENV['MERB_ENV'] || 'test')
require "merb-ext/spec_custom_matchers"

Spec::Runner.configure do |config|
  config.include(Merb::Test::ViewHelper)
  config.include(Merb::Test::RouteHelper)
  config.include(Merb::Test::ControllerHelper)
  config.include(MerbExt::SpecCustomMatchers)
  
  config.before(:all) do
    DataMapper.auto_migrate! if Merb.orm == :datamapper
  end
  
end

def log_in_as(login, opts = {})  
  visit "/login"
  fill_in "login", :with => login
  fill_in "password", :with => opts[:password] || "mapex"
  click_button "Zaloguj"
end

def log_out
  visit "/logout"
end

def create_user(login = "teamon", opts = {})
  opts[:password_confirmation] = opts[:password] ||= "mapex"
  User.create(ValidProperties.user.merge({:login => login}.merge(opts)))
end


class ValidProperties
  class << self
    def user
      {
        :login => 'teamon',
        :email => 'i@teamon.eu',
        :password => 'mapex',
        :password_confirmation => 'mapex',
        :year => 1,
        :faculty => Faculty.get(4) || Faculty.create(self.faculty)
      }
    end
    
    def faculty
      {
        :id => 4,
        :name => "Electronics"
      }
    end
  end
end

require "spec/fixtures"
