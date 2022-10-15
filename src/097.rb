#!/usr/bin/env ruby
require_relative 'projecteuler'
t0 = Time.now
mod = 10**10

puts (mod_exp(2, 7_830_457, mod) * 28_433 % mod + 1).to_s[-10..-1]
puts "#{Time.now - t0} s"
