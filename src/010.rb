#!/usr/bin/env ruby
require_relative 'projecteuler'

is_prime = sieve_atkin(2_000_000)
sum = 2
3.step(2_000_000, 2) do |i|
  sum += i if is_prime[i]
end
puts sum
