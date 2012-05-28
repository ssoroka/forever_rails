require 'test_helper'

class ForeverThreadWorkerTest < Test::Unit::TestCase
  class WorkerWithoutRun < ForeverThreadWorker
    every 1
  end

  def test_worker_without_run_should_raise
    worker = WorkerWithoutRun.new

    assert_raise NotImplementedError do
      worker.run
    end
  end

  def test_worker_without_run_should_not_run_forever
    worker = WorkerWithoutRun.new

    assert_raise NotImplementedError do
      worker.run_forever
      worker.wait_for_quit
    end
  end

  def test_worker_should_call_run_when_running_forever
    worker = WorkerWithoutRun.new

    WorkerWithoutRun.any_instance.expects(:run).with do
      worker.stop!
      true
    end

    worker.run_forever
    worker.wait_for_quit
  end
end
