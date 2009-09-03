require 'rubygems'
require 'rake/rdoctask'

require 'merb-core'
require 'merb-core/tasks/merb'

include FileUtils

# Load the basic runtime dependencies; this will include 
# any plugins and therefore plugin rake tasks.
init_env = ENV['MERB_ENV'] || 'rake'
Merb.load_dependencies(:environment => init_env)
     
# Get Merb plugins and dependencies
Merb::Plugins.rakefiles.each { |r| require r } 

# Load any app level custom rakefile extensions from lib/tasks
tasks_path = File.join(File.dirname(__FILE__), "lib", "tasks")
rake_files = Dir["#{tasks_path}/*.rake"]
rake_files.each{|rake_file| load rake_file }

desc "Start runner environment"
task :merb_env do
  Merb.start_environment(:environment => init_env, :adapter => 'runner')
end

require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
desc 'Default: run spec examples'
task :default => 'spec'

##############################################################################
# ADD YOUR CUSTOM TASKS IN /lib/tasks
# NAME YOUR RAKE FILES file_name.rake
##############################################################################
task :fixtures => :merb_env do
  include DataMapper::Sweatshop::Unique
  DataMapper.auto_migrate!
  
  w1 = Faculty.create(:code => 'W-1', :name => 'Architektura')
  w2 = Faculty.create(:code => 'W-2', :name => 'Budownictwo')
  w3 = Faculty.create(:code => 'W-3', :name => 'Chemiczny')
  w4 = Faculty.create(:code => 'W-4', :name => 'Elektronika')
  w5 = Faculty.create(:code => 'W-5', :name => 'Elektryczny')
  w6 = Faculty.create(:code => 'W-6', :name => 'Geoinżynieria, Górnictwo i Geologia')
  w7 = Faculty.create(:code => 'W-7', :name => 'Inżynieria rodowiska')
  w8 = Faculty.create(:code => 'W-8', :name => 'Informatyka i Zarządzanie')
  w9 = Faculty.create(:code => 'W-9', :name => 'Mechaniczno Energetyczny')
  w10 = Faculty.create(:code => 'W-10', :name => 'Mechaniczny')
  w11 = Faculty.create(:code => 'W-11', :name => 'Podstawowych Problemów Techniki')
  w12 = Faculty.create(:code => 'W-12', :name => 'Elektroniki Mikrosystemów i Fotoniki')
  skp = Faculty.create(:code => 'SKP', :name => '- Studium Ksztacenia Podstawowego')
  
  User.create(:login => "teamon", :email => "i@teamon.eu", :name => "Tymon Tobolski", 
      :password => "mapex", :password_confirmation => "mapex", :faculty => w4, :year => 1)  
  
  # User.fix {{
  #   :name => /\w+ \w+/.gen,
  #   :email => unique {|i| "#{/\w+/.gen}@example.com" },
  #   :password => (password = /\w+/.gen),
  #   :password_confirmation => password
  # }}

end