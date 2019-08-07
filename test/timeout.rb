require 'minitest/autorun'
require 'timeout_queue'

describe "pop an empty queue" do

  let(:q){ TimeoutQueue.new }

  describe "with a timeout" do
  
    it "raises ThreadError" do
  
      assert_raises ThreadError do
        q.pop(timeout: 1)
      end
    
    end
  
  end
  
  describe "with non_blocking" do
  
    it "raises ThreadError" do
  
      assert_raises ThreadError do
        q.pop(true)
      end
    
    end
  
  end
  
end
