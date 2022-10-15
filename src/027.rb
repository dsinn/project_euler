#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

is_prime = sieve_atkin(2_001_000)
max_n = -1
answer = -1
get_primes(1000).each do |b|
  (-b + (b + 1) % 2..1000).step(2) do |a|
    n = 0
    n += 1 while is_prime[n * (n + a) + b]
    if max_n < n
      max_n = n
      answer = a * b
    end
  end
end

puts answer
puts "#{Time.now - t0} s"
