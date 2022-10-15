#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

x = 1
width = 1
diagonals = 1
increment = 2
primesx10 = 0

loop do
  # Odd case
  x += increment
  primesx10 += 10 if prime? x
  diagonals += 1
  width += 1
  break if primesx10 < diagonals

  # Even case
  x += increment
  primesx10 += 10 if prime? x
  x += increment
  primesx10 += 10 if prime? x
  x += increment # Bottom-right corner is always a square, which cannot be prime
  diagonals += 3
  increment += 2
  width += 1
  break if primesx10 < diagonals
end

puts width
puts "#{Time.now - t0} s"
