#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

primes = get_primes(999)
answer = -1
max_len = -1
primes.each do |d|
  h = {}
  place = 0
  numerator = 1
  loop do
    numerator *= 10
    if h.key?(numerator)
      len = place - h[numerator]
      if max_len < len
        max_len = len
        answer = d
      end
      break
    end
    h[numerator] = place
    numerator %= d
    place += 1
  end
end

puts answer
puts "#{Time.now - t0} ms"
