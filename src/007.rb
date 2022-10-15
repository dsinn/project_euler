#!/usr/bin/env ruby
require_relative 'projecteuler'

x = 10_001
upper_limit = (x * (Math.log(x) + Math.log(Math.log(x)))).floor # Rosser's theorem
is_prime = sieve_atkin(upper_limit)
count = 1
3.step(upper_limit, 2) do |i|
  if is_prime[i]
    count += 1
    if count == x
      puts i
      break
    end
  end
end
