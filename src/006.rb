require_relative 'projecteuler.rb'

x = 100
sumOfSquares = (2 * x ** 3 + 3 * x ** 2 + x) / 6
squareOfSum = arithmetic_series_sum(1, x, 1) ** 2

puts squareOfSum - sumOfSquares
