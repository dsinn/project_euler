#!/usr/bin/env ruby
require_relative 'libs/sum_of_divisors'

limit = 10_000
d = SumOfDivisors.generate(limit)

counted = {}
sum = 0
(1..limit).each do |a|
  next if counted.key?(a)

  b = d[a]
  next unless (d[b] == a) && (a != b)

  puts "#{a} #{b}"
  sum += a + b
  counted[b] = true
end
puts sum
