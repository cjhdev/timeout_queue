class TimeoutQueue
    
  def initialize(**opt)
  
    @queue = []
    @mutex = Mutex.new
    @received = ConditionVariable.new
      
  end
  
  # push object into end of queue
  #
  # @param object
  # @return object
  #
  def push(object, **opt)
    __push do 
      @queue.send(__method__, object)
    end  
  end
  
  # push object into front of the queue
  #
  # @param object
  # @return object
  #
  def unshift(object)
    __push do 
      @queue.send(__method__, object)
    end
  end
  
  # delete an object from the queue before it can be popped
  #
  # @param object
  # @return object
  #
  def delete(object)
  
    with_mutex do        
      @queue.delete(object)                                
    end
  
    object
  
  end
  
  # retrieve next object from queue
  #
  # @param non_block [TrueClass,FalseClass] set true to enable non-blocking mode
  # @param opts [Hash]
  #
  # @option opts [Float,Integer] :timeout seconds to wait (in blocking mode)
  #
  # @raise ThreadError if timeout expires or queue is empty in non_block mode
  # 
  def pop(non_block=false, **opts)
  
    timeout = opts[:timeout]
  
    if timeout
                
      end_time = Time.now + timeout.to_f
    
    end
      
    with_mutex do
    
      while @queue.empty? and not(non_block)
      
        if timeout
        
          break unless ((time_now = Time.now) < end_time)            
          
          @received.wait(@mutex, end_time - time_now)
            
        else
        
          @received.wait(@mutex)
            
        end
      
      end 
      
      raise ThreadError unless not @queue.empty?
                             
      @queue.shift
            
    end
  
  end

  def empty?
    @queue.send __method__
  end

  def size
    @queue.send __method__
  end
  
  def clear
    with_mutex do
      @queue.clear
    end
    self
  end

  def with_mutex
    @mutex.synchronize do
      yield
    end
  end
  
  def __push(object)
    with_mutex do          
      yield
      @received.signal                
    end    
    object
  end

  alias_method :length, :size
  
  alias_method :'<<', :push
  alias_method :enq, :push

  alias_method :shift, :pop
  alias_method :deq, :pop
  
  private :with_mutex, :__push

end

require 'timeout_queue/version'
