set :application, "captest"
set :repository,  "git@github.com:bklein/captest.git"

set :scm, :git

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
server "captest.slammervanity.com", :web, :app, :db, primary: true

set :user, "bklein"
set :deploy_to, "/www3/#{application}"
set :deploy_via, :remote_cache
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
  
  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    puts File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Edit the files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"
 end


