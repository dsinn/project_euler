#!/usr/bin/env ruby
require_relative 'projecteuler'
t0 = Time.now
limit = 1000
mod = 10**10
total = 0
(1..limit).each do |i|
  total = (total + mod_exp(i, i, mod)) % mod
end
puts total

t1 = Time.now
total = 0
(1..limit).each do |i|
  total += i**i
end
puts total % mod

puts "#{t1 - t0} s"
puts "#{Time.now - t1} s"
