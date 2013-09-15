# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require 'rake'
require 'resque/tasks'
require 'resque_scheduler'
require 'resque_scheduler/tasks'
require 'resque_scheduler/server'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

SocialAggregator::Application.load_tasks
