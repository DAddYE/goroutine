class Channel < Queue
  include Goroutine
end

class Channel::Buffered < SizedQueue
  include Goroutine
end
