require 'bundler/setup'
require 'goroutine'

# Single buffered channel, it's immediate so the publisher will complete before he'll get any
# subscription (edge case)
channel = Channel::Buffered.new(5)
go do
  10.times { |i| channel << i }
  channel << :quit
end

# Subscribe a "completed" channel
select(channel) do |val|
  break if val == :quit
  p val
end
