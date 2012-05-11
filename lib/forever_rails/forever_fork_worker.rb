class ForeverForkWorker < ForeverWorkerBase
  attr_accessor :pid

  def stop!
    @stopped = true
    Process.kill(:INT, @pid)
  end

  def run_forever
    @pid = Process.fork do
      reopen_logs
      after_fork
      trap_signals
      logger.info("Started new #{self.class.name} worker")

      last_run = 0
      while !stopped
        now = Time.now.to_i
        if now - last_run > @@timespan
          last_run = now
          begin
            run
          rescue StandardError => e
            logger.error("Caught #{e.class.name} while running #{self.class.name}: #{e.message}\n--  #{e.backtrace.join("\n--  ")}")
          end
        else
          sleep 1
        end
      end
      logger.info("Stopping #{self.class.name} worker")
    end
  end

  def wait_for_quit
    Process.wait(@pid)
  end

  def reopen_log
    
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
