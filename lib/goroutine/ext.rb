module Kernel
  def select(channels, &block)
    channels = Array(channels)
    loop do
      rs, _ = IO.select(channels)
      rs.each { |ch| block[ch.pop, channels.index(ch)] }
    end
  end

  def go(*args, &block)
    Thread.abort_on_exception = true
    Thread.new(*args, &block)
  end
end
