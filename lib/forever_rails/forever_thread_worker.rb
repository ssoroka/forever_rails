class ForeverThreadWorker < ForeverWorkerBase
  attr_accessor :thread

  def run_forever
    @thread = Thread.new do
      super
    end
  end

  def wait_for_quit
    @thread.join
  end
end
