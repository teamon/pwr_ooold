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
  require "spec/fixtures"
  load_fixtures!
end

namespace :heroku do
  desc "Create Heroku`s .gems file"
  task :gems => :merb_env do
    $GEMS = []

    def bundle_path(*); nil; end
    def gem(name, version, *args)
      $GEMS << "#{name} -v #{version}"
    end

    Kernel.load "Gemfile"
    File.open(".gems", "w") {|f| f.write $GEMS.join("\n") }
  end
  
  desc "Get Heroku`s config vars"
  task :config do
    `heroku config`.each{|e| 
      cmd = "export #{e.split("=>").map {|a| a.strip}.join("=")}"
      puts cmd
      system(cmd)
    }
  end
end