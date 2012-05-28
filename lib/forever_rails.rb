require "forever_rails/version"
require "forever_rails/forever"
require "forever_rails/forever_worker_base"
require "forever_rails/forever_thread_worker"
require "forever_rails/forever_fork_worker"

ForeverWorker = ::ForeverThreadWorker

require "railtie" if defined?(Rails)

