#!/usr/bin/env ruby
require_relative 'primes'

t0 = Time.now

def sorted_string(n)
  n.to_s.chars.sort.join
end

is_prime = Primes.prime_map(9999)
answer = 0
1001.step(9999, 2) do |i|
  if answer > 0
    break
  elsif is_prime[i]
    2.step((9999 - i) >> 1, 2) do |inc|
      j = i + inc
      k = i + (inc << 1)
      if !((i == 1487) && (j == 4817) && (k == 8147)) && is_prime[j] && is_prime[k]
        s = sorted_string(i)
        if (s == sorted_string(j)) && (s == sorted_string(k))
          puts i.to_s + j.to_s + k.to_s
          answer = i + j + k
        end
      end
    end
  end
end

puts answer
puts "#{Time.now - t0} s"
