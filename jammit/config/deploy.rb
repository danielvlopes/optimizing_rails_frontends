# APP SETTINGS
set :application, "APPNAME"
set :domain_name , "www.appname.com"

# GIT SETTINGS
set :scm, :git
set :repository,  "git@github.com:danielvlopes/REPO.git"
set :branch, "master"
set :deploy_via, :remote_cache

# SSH SETTINGS
set :user , "USERNAME"
set :deploy_to, "~/#{application}"
set :shared_directory, "#{deploy_to}/shared"
set :use_sudo, false
set :group_writable, false
default_run_options[:pty] = true

# ROLES
role :app, domain_name
role :web, domain_name
role :db,  domain_name, :primary => true

#TASKS
after 'deploy:symlink', 'assets:jammit'

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

namespace :assets do
  desc "run jammit locally and upload files to current release"
  task :jammit, :roles => :web do
    root_path = File.join(File.dirname(__FILE__), "..")
    run_locally "cd #{root_path} && jammit"
    upload "#{root_path}/public/assets", "#{current_release}/public", :via => :scp, :recursive => true
  end
end