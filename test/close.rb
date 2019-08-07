require 'minitest/autorun'
require 'timeout_queue'

describe "close a queue" do

  let(:q){ TimeoutQueue.new }
  
  it "is not closed to start" do
  
    refute q.closed?
  
  end
  
  describe "with waiters" do
  
    before do    
      
      q.closed?
      
      Thread.new do
      
        assert_raises ClosedQueueError do        
          q.pop        
        end
      
      end
      
      q.close    
      
    end
  
    it "is closed" do      
      assert q.closed?    
    end
    
  end
  
end
