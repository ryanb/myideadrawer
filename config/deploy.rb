set :application, "myideadrawer.com"
role :app, "72.14.181.32"
role :web, "72.14.181.32"
role :db,  "72.14.181.32", :primary => true

set :user, "rbates"
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:railsrumble/teamwnn.git"
set :branch, "master"

namespace :deploy do
  desc "Tell Passenger to restart."
  task :restart, :roles => :web do
    run "touch #{deploy_to}/current/tmp/restart.txt" 
  end
  
  desc "Do nothing on startup so we don't get a script/spin error."
  task :start do
    puts "You may need to restart Apache."
  end

  desc "Symlink extra configs and folders."
  task :symlink_extras do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/app_config.yml #{release_path}/config/app_config.yml"
  end

  desc "Setup shared directory."
  task :setup_shared do
    run "mkdir #{shared_path}/config"
    put File.read("config/examples/database.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/examples/app_config.yml"), "#{shared_path}/config/app_config.yml"
    puts "Now edit the config files and fill assets folder in #{shared_path}."
  end
end

after "deploy", "deploy:cleanup" # keeps only last 5 releases
after "deploy:setup", "deploy:setup_shared"
after "deploy:update_code", "deploy:symlink_extras"
