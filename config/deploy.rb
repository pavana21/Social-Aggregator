require "rvm/capistrano"
require "bundler/capistrano"
set :application, "social_aggregator"
set :rails_env, "production"
set :env, "production"
set :domain, "social_aggregator.com"
set :user, "root"
set :branch, "master"
set :deploy_to, "/var/www/rails_apps/social_aggregator"
server "174.34.171.54", :web, :app, :db, primary: true

set :repository,  "git@github.com:pavana21/Social-Aggregator.git"

set :scm, :git
default_run_options[:pty] = true
set :use_sudo, false
set :rvm_type, :system
set :sudo_prompt, ""
load 'deploy/assets'

set :deploy_via, :remote_cache
set :repository_cache, "cached_copy"

after "deploy", "deploy:cleanup"

def god_run(command)
  run "cd #{current_path} && #{sudo} bundle exec god #{command}"
end

namespace :god do
  task :start do
    god_run "-c config/god/resque.god --log log/resque.log"
  end

  task :reload do
    god_run "load config/god/resque.god --log log/resque.log"
  end

  task :stop do
    god_run "quit"
  end

  task :status do
    god_run "status"
  end

  task :restart do
    god.stop
    god.start
  end
end

namespace :resque do
  task :restart do
    god_run "restart resque"
  end

  task :stop do
    god_run "stop resque"
  end

  task :start do
    god_run "start resque"
  end
end


namespace :deploy do
    task :start do
      god.start
    end

    task :restart, :roles => :app, :except => { :no_release => true } do
      god.restart
      resque.restart
    end

    task :stop do
      resque.stop
    end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  
  before "deploy", "deploy:check_revision"
end
