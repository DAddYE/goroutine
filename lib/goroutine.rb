require 'goroutine/version'
require 'goroutine/channel'
require 'goroutine/ext'

module Goroutine
  def initialize(*args)
    super(*args)
    @rd, wr = IO.pipe
    rd, @wr = IO.pipe
    go do
      loop do
        IO.select([rd])
        rd.read(1)
        wr.write('.')
      end
    end
  end

  def pop
    @rd.read(1)
    super
  end
  alias shift pop
  alias deq pop

  def push(val)
    @wr.write('.')
    super(val)
  end
  alias << push
  alias enq push

  def to_io
    @rd
  end

  def wait
    IO.select([self])[0]
  end
  alias :ready :wait
end
