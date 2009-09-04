set :application, "pwr"

set :scm, :git
set :repository,  "git://github.com/teamon/pwr.git"
# default_run_options[:pty] = true
# set :scm_password, Proc.new { Capistrano::CLI.password_prompt "SCM Password: "}

set :deploy_to, "/home/teamon/rails_apps/#{application}"

set :use_sudo, false

role :app, "drakor.eu"
role :web, "drakor.eu"
role :db,  "drakor.eu", :primary => true

set :merb_adapter,     "thin"
set :merb_environment, ENV["MERB_ENV"] || "production"
set :merb_port,        3033
set :merb_servers,     1

namespace :deploy do
  desc "stops application server"
  task :stop do
    run "cd #{current_path}; merb -K all"
  end
  
  desc "starts application server"
  task :start do
    run "cd #{current_path}; merb -a #{merb_adapter} -p #{merb_port} -c #{merb_servers} -d -e #{merb_environment}"
    # Mutex of: -X off
  end
  
  desc "restarts application server(s)"
  task :restart do
    deploy.stop
    deploy.start
  end

end

namespace :db do
  task :setup, :except => { :no_release => true } do
    config = <<-EOF
    ---
    :development: &defaults
      :adapter: sqlite3
      :database: #{shared_path}/db/development.sqlite3
      :encoding: utf8

    :rake:
      <<: *defaults

    :test:
      <<: *defaults
      :database: #{shared_path}/db/test.sqlite3

    :production:
      <<: *defaults
      :database: #{shared_path}/db/production.sqlite3
    EOF
     
    run "mkdir -p #{shared_path}/db"
    run "mkdir -p #{shared_path}/config"
     
    put config, "#{shared_path}/config/database.yml"
     
  end
  
  desc <<-DESC
    [internal] Updates the symlink for database.yml file to the just deployed release.
  DESC
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  
  after "deploy:setup", "db:setup"
  after "deploy:finalize_update", "db:symlink"
end

namespace :uploads do
  desc <<-DESC
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  DESC
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }.join(" ")
    run "mkdir -p #{dirs} && chmod g+w #{dirs}"
  end
  
  desc <<-DESC
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  DESC
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
    run "rm -rf #{release_path}/public/packages"
    run "ln -nfs #{shared_path}/packages #{release_path}/public/packages"
  end
  
  desc <<-DESC
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  DESC
  task :register_dirs do
    set :uploads_dirs,    %w(uploads packages)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end
  
  after "deploy:finalize_update", "uploads:symlink"
  on :start, "uploads:register_dirs"
  
end
