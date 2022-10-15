#!/usr/bin/env ruby
t0 = Time.now
target = 10**6
n_max = 10**2

n = 1
r = 0
ncr = 1
# Travel down the middle of Pascal's triangle until the value of nCr is high enough
while ncr < target
  n += 1
  if (n & 1).zero?
    r += 1
    ncr = ncr * n / r
  else
    ncr = ncr * n / (r + 1)
  end
end
answer = (2 + n + n_max) * (n_max - n + 1) / 2 # The number of terms in rows n .. n_max using arithmetic series

# # Uncomment this block to cheat a bit by using the problem's description:
# Since 23C10 is the first value, we know 23Cr > 10^6 for r in [10, 13]
# and that 24C10 is above one million, so continue from 24C9.
# answer = 4 + (25 + n_max + 1) * (n_max - 23) / 2
# n = 24
# r = 9
# ncr = 4 * 23 * 22 * 19 * 17 * 2 # 24C9; eliminated denominator for teh lulz

while n <= n_max
  # Go left until nCr is below the value
  while ncr >= target
    ncr = ncr * r / (n - r + 1)
    r -= 1
  end
  # Count the number of terms on the row that are below one million, then subtract from the total.
  # r is the largest integer less than n/2 such that nCr < target.
  # Since Pascal's triangle is symmetrical, the number is |[0 .. r]| * 2.
  answer -= r + 1 << 1
  # Move one to the bottom-left
  n += 1
  ncr = ncr * n / (n - r)
end

puts answer
puts "#{Time.now - t0} s"
