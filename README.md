# Goroutine

This is a very simple implementation of `channels` in pure ruby in like [40
lines](lib/goroutine.rb) of code and with the help of unix `pipes` and `IO.select`

It's composed by two components: `Queue` and `IO.pipe`, the `Queue` can be **buffered**.

This project is in a very **early stage**.

## Usage

![demo](http://fs.daddye.it/qKUU+)

Let's start with some examples:

### GO and Channel

A very basic program could be:

```rb
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
```

[go](lib/goroutine/ext.rb) method is nothing more than a `Thread.new {}`, just shorter.

### Select

You can use the `select` method to wait for one or **more** (the latter is
interesting) channels.

```rb
channel = Channel.new

go do
  10.times { |i| channel << i; sleep 1 }
  channel << :quit
end

select(channel) do |val|
  break if val == :quit
  p val
end
```

You can use `break` to stop and exit from a `select` block.

However `select` becomes more interesting when using multiple channels:

```rb
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
```

The output will be like:

```
<ch:1, message: 1>
<ch:2, message: 2>
<ch:1, message: 3>
<ch:0, message: 4>
<ch:4, message: 5>
<ch:3, message: 6>
<ch:2, message: 7>
```

### Buffered Channel

If necessary, you can have a buffered channel:

```rb
channel = Channel::Buffered.new(5)
go do
  10.times { |i| channel << i; sleep 1 }
  channel << :quit
end

# Subscribe a "completed" channel
select(channel) do |val|
  break if val == :quit
  p val
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'goroutine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install goroutine

## Inspirations and Mentions

It's worth to mention that if you are looking for a more sophisticated version of `goroutines` you
should checkout [agent](https://github.com/igrigorik/agent) by [Ilya
Grigorik](https://www.igvita.com)

Of course, this idea is yet another attempt to model [go
channels](http://golang.org/doc/effective_go.html#channels)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/goroutine/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## LICENSE

Copyright (C) 2014 Davide D'Agostino

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
