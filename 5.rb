require_relative 'projecteuler.rb'

x = 20
for i in 11 .. 19
    x = lcm(x, i)
end
puts x
