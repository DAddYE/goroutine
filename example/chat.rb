require 'bundler/setup'
require 'goroutine'

room = Channel.new

go do
  room << ['You', STDIN.gets] while true
end

go('Stan', 'Francine', 'Roger') do |*names|
  names.each do |who|
    room << [who, "hello!"]
    sleep 1
  end
  room << ['Klaus', "how are you?"]
end

select(room) do |(who, text)|
  puts "\e[01m#{who}\e[0m said:\t#{text}"
  break if who == 'You'
end
