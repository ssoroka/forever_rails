require "active_support/core_ext/class/attribute_accessors"
require "logger"

class ForeverWorkerBase
  cattr_accessor :timespan

  def self.every(time)
    @@timespan = time  
  end

  attr_accessor :logger
  def initialize(options={})
    @logger = options[:logger] || Logger.new(STDOUT)
    @stopped = false
  end

  def stop!
    @stopped = true
  end

  def stopped?
    @stopped
  end

  # override this in subclass to implement a single run
  def run
    raise NotImplementedError
  end

  def run_forever
    last_run = nil
    while !stopped?
      now = Time.now.to_i
      if !last_run || (now - last_run > timespan)
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

  def wait_for_quit
  end
end
