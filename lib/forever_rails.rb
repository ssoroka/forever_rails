require "forever_rails/version"
require "forever_rails/forever"
require "forever_rails/forever_worker_base"
require "forever_rails/forever_thread_worker"
require "forever_rails/forever_fork_worker"

ForeverWorker = ::ForeverThreadWorker

module ForeverRails
  class RakeTasks < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load File.expand_path(f) }
    end
  end
end

