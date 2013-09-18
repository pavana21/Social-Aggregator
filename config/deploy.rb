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
set :queue_name, "*"
set :num_of_queues, 3

after "deploy", "deploy:cleanup"
after "deploy:symlink", "deploy:restart_workers"
after "deploy:restart_workers", "deploy:restart_scheduler"

def run_remote_rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')
  cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
  cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
  run cmd
  set :rakefile, nil if exists?(:rakefile)
end
 
namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
      run "/etc/init.d/redis #{command}"
    end
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

  desc "Restart Resque Workers"
  task :restart_workers, :roles => :db do
    run_remote_rake "resque:restart_workers"
  end
 
  desc "Restart Resque scheduler"
  task :restart_scheduler, :roles => :db do
    run_remote_rake "resque:restart_scheduler"
  end
  
  before "deploy", "deploy:check_revision"
end
