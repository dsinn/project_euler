require_relative 'projecteuler.rb'
t0 = Time.now
mod = 10 ** 10

puts (mod_exp(2, 7830457, mod) * 28433 % mod + 1).to_s[-10 .. -1]
puts (Time.now - t0).to_s + ' s'