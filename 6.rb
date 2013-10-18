require_relative 'projecteuler.rb'

first = 0
for i in 1 .. 100
    first += i * i
end

second = arithmetic_series_sum(1, 100, 1)
second *= second

puts second - first