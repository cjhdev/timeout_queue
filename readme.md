timeout_queue
=============

It's like Queue except:

- #pop has an optional timeout
- #unshift will put an object on the front of the queue
- #delete can remove an object from the queue

## Usage

Install as a Gem using your preferred method.

Require:

~~~
require 'timeout_queue'
~~~

Use:

~~~
q = TimeoutQueue.new

begin

    # wait for no more than one second
    q.pop(timeout: 1)
    
rescue ThreadError
    
    # you timed out
    
end
~~~

## License

timeout_queue has an MIT license.
