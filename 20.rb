require_relative 'projecteuler.rb'

s = factorial(100).to_s
sum = 0
s.split('').each do |c|
    sum += c.to_i
end
puts sum