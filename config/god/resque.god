rails_env   = ENV['RAILS_ENV']  || "production"
rails_root  = File.dirname(File.expand_path('./../../',__FILE__))
puts "Rails Root: #{rails_root}"
num_workers = 1

num_workers.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.env      = {"QUEUE"=>"*", "RAILS_ENV"=>rails_env, "VERBOSE" => 'true'}
    w.start    = "bundle exec rake resque:work"
    w.stop     = "bundle exec rake resque:stop_workers"
    w.start_grace = 10.seconds
    w.restart_grace = 120.seconds
    w.log = "#{rails_root}/log/resque.log"

    # retart if memory/cpu gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        c.above = 350.megabytes
        c.times = 2
      end

      on.condition(:cpu_usage) do |c|
        c.above = 50.percent
        c.times = 5
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
      end
    end
  end
end
