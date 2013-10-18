require_relative 'projecteuler.rb'
t0 = Time.now
limit = 1000
mod = 10 ** 10
total = 0
for i in 1 .. limit
    total = (total + mod_exp(i, i, mod)) % mod
end
puts total

t1 = Time.now
total = 0
for i in 1 .. limit
    total += i ** i
end
puts total % mod

puts (t1 - t0).to_s + ' s'
puts (Time.now - t1).to_s + ' s'
