require "active_support/core_ext/class/attribute_accessors"

class ForeverWorkerBase
  cattr_accessor :timespan
  def self.every(time)
    @@timespan = time  
  end

  attr_accessor :stopped, :logger, :thread
  def initialize(options)
    @logger = options[:logger]    
    @stopped = false
  end

  def stop!
    @stopped = true
  end

  # override this in subclass to implement a single run
  def run
  end

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
