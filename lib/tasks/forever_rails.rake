namespace :forever_rails do
  desc "start task workers"
  task :start_workers do
    puts "Starting workers"
    forever = Forever.new
    forever.run
  end

  task :stop_workers do
    puts "Stopping workers"

  end
end