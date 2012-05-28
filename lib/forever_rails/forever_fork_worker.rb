class ForeverForkWorker < ForeverWorkerBase
  attr_accessor :pid

  def stop!
    super
    Process.kill(:INT, @pid) if @pid
  end

  def run_forever
    @pid = Process.fork do
      reopen_logs
      after_fork
      trap_signals
      logger.info("Started new #{self.class.name} worker")

      super

      logger.info("Stopping #{self.class.name} worker")
    end
  end

  def wait_for_quit
    Process.wait(@pid)
  end

  def reopen_logs
    
  end

  # use this to reopen the db, logs, redis, etc.
  def after_fork
  end

  def trap_signals
    %w(INT TERM).each do |sig|
      trap(sig) do
         logger.info("Caught #{sig}, terminating.")
        stop!
      end
    end
  end
end
