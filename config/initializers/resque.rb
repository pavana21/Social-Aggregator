require 'resque'
require 'resque_scheduler'
require 'yaml'
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

redis_config = YAML.load_file(rails_root + '/config/redis.yml')
Resque.redis = redis_config[rails_env]['resque']
jobs = File.expand_path("/../../jobs/*.rb", __FILE__)
puts "Jobs Listings: #{jobs}"
Dir.glob("jobs/*.rb").each {|file| require "./#{file}"}
Resque.schedule = YAML.load_file(File.expand_path("../../resque_schedule.yml",__FILE__))
require 'resque_scheduler/server'