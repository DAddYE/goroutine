require 'bundler/setup'
require 'goroutine'

chan = Channel.new

go do
  loop do
    chan << :hello!
    sleep 1
  end
end

while chan.ready
  p chan.pop
end
