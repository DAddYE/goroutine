require 'bundler/setup'
require 'goroutine'

file = File.open(__FILE__) # read myself
channels = 10.times.map { Channel.new }

# Simulate slow reading
puts 'Start a slow reading'
go do
  while buf = file.read(16)
    channels.sample << buf
    sleep 0.5
  end
  channels.each { |chan| chan << :exit }
end

# Do something now
puts 'Doing something else'

# Okay, now, it's time to read
puts 'Waiting for lines'
select(channels) do |line|
  break if line == :exit
  print line
end

file.close
