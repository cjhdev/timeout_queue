require 'minitest/autorun'
require 'timeout_queue'

describe "pop a closed queue" do

  describe "queue is empty" do

    let(:q){ TimeoutQueue.new.close }

    describe "without a timeout" do
    
      it "raises ClosedQueueError" do
    
        assert_raises ClosedQueueError do
          q.pop
        end
      
      end
    
    end
    
    describe "with a timeout" do
    
      it "raises ClosedQueueError" do
    
        assert_raises ClosedQueueError do
          q.pop(timeout: 1)
        end
      
      end
    
    end
    
    describe "with non_blocking" do
    
      it "raises ClosedQueueError" do
    
        assert_raises ClosedQueueError do
          q.pop(true)
        end
      
      end
    
    end
    
  end
  
  describe "queue is not empty" do
  
    let(:obj) { {} }
    let(:q){ TimeoutQueue.new }
    
    before do
    
      q.push obj
      
      q.close
    
    end
    
    it "returns obj" do
    
      assert_equal obj, q.pop
    
    end
    
  end
  
end
