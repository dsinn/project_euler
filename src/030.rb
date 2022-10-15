#!/usr/bin/env ruby
require_relative 'projecteuler'

t0 = Time.now
digits = [0, 0, 0, 0, 0, 2]
last_index = digits.length - 1
hypercubes = Array.new(10) do |i|
  j = i * i
  j * j * i
end

lenminus = digits.length - 1

total = 0
(2..hypercubes[9] * 6).each do |i|
  sum = 0
  digits.each do |digit|
    sum += hypercubes[digit]
  end

  if i == sum
    puts i
    total += i
  end

  lenminus.downto(0) do |j|
    if digits[j] < 9
      digits[j] += 1
      break
    else
      digits[j] = 0
    end
  end
end
puts total
puts "#{Time.now - t0} s"
