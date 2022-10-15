#!/usr/bin/env ruby
collatz_lengths = {}
collatz_lengths[1] = 1
max = 0
answer = -1

3.step(1_000_000, 2) do |i|
  n = i
  stack = []
  until collatz_lengths.key?(n)
    stack << n
    if (n & 1).zero?
      n >>= 1
    else
      n = 3 * n + 1
    end
  end

  len = stack.length + collatz_lengths[n]
  if max < len
    max = len
    answer = i
  end

  # Put computed lengths into array
  (0..stack.length - 1).each do |j|
    collatz_lengths[stack[j]] = len
    len -= 1
  end
end

puts answer
puts max
