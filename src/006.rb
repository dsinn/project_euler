require_relative 'projecteuler'

x = 100
sum_of_squares = (2 * x**3 + 3 * x**2 + x) / 6
square_of_sum = arithmetic_series_sum(1, x, 1)**2

puts square_of_sum - sum_of_squares
