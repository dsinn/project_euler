#!/usr/bin/env ruby
require_relative 'projecteuler'

t0 = Time.now

product = 1
factorials = Array.new(10)
factorials[0] = 1
factorials[1] = 1
(2..9).each do |i|
  product *= i
  factorials[i] = product
end

total = 0
(2..7).each do |len|
  sigma_star([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], len).each do |digits|
    next unless digits[0] > 0

    sum = 0
    digits.each do |digit|
      sum += factorials[digit]
    end

    if sum == digits.join('').to_i
      puts sum
      total += sum
    end
  end
end

puts total
puts "#{Time.now - t0} s"
