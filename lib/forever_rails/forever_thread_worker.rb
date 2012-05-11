class ForeverThreadWorker < ForeverWorkerBase
  attr_accessor :thread

  def run_forever
    @thread = Thread.new do
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
    end
  end

  def wait_for_quit
    @thread.join
  end
end
