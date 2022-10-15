#!/usr/bin/env ruby
a = 1
b = 2

sum = 0
while b <= 4_000_000
  sum += b
  # Every third Fibonacci number is even
  # 1st iter: b, a + b
  # 2nd iter: a + b, a + 2b
  # 3rd iter...
  a, b = a + 2 * b, 2 * a + 3 * b
end
puts sum
