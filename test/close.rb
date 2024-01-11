require 'minitest/autorun'
require 'timeout_queue'

describe "close a queue" do

  let(:q){ TimeoutQueue.new }
  
  describe "new queue is not closed" do

    it "is not closed to start" do

      refute q.closed?

    end

  end
  
  describe "with waiters" do
  
    before do    

      q.closed?

      Thread.new do

        sleep 0.5

        q.close
      
      end
      
    end
  
    it "is closed" do

      assert_raises ClosedQueueError do
        q.pop
      end

      assert q.closed?

    end
    
  end

end
