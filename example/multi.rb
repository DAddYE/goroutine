require 'bundler/setup'
require 'goroutine'

channels = 5.times.map { Channel.new }

# Simulating a long running worker
go(0) do |i|
  while i += 1
    channels.sample << i
    sleep 1
  end
end

# Reader
select(channels) do |val, i|
  puts "<ch:#{i}, message: #{val}>"
  break if val > 9
end
