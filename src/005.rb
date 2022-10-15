require_relative 'projecteuler'

x = 20
(11..19).each do |i|
  x = lcm(x, i)
end
puts x
