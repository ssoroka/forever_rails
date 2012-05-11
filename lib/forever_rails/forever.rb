class Forever
  attr_accessor :logger
  def initialize(options = {})
    setup_logger(options[:logger])
    load_environment
    load_workers
    capture_signals
  end

  def setup_logger(logger = nil)
    @logger = logger || Logger.new(STDOUT)
  end

  def load_environment
    unless defined?(Rails)
      logger.info "Loading rails environment"
      Bundler.load
      Bundler.require
      require 'config/environment'
    end
  end

  def load_workers
    logger.info "loading workers"
    @workers = []
    worker_classes.each do |klass|
      @workers.push klass.new(:logger => logger)
    end
  end

  def capture_signals
    %w(INT TERM).each do |sig|
      trap(sig) do
        logger.info("Caught #{sig}, terminating.")
        stop!
      end
    end
  end

  def run
    logger.info "Running"
    @workers.each &:run_forever
    @workers.each &:wait_for_quit
  end

  def stop!
    @workers.each &:stop!
  end

  private
  def worker_classes
    Dir['app/background_workers/**/*.rb'].each do |file|
      require file
    end
  end
end
