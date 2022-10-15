#!/usr/bin/env ruby
x = 600_851_475_143
factors = []

# Check if even
while (x & 1).zero?
  x /= 2
  factors << 2
end

operand = 3
sqrt_x = Math.sqrt(x).floor

while x > 1 && operand < sqrt_x
  while (x % operand).zero?
    factors << operand
    x /= operand
    sqrt_x = Math.sqrt(x).floor
  end
  operand += 2
end

factors << x if x > 1

puts factors
