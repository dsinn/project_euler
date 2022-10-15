#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'
limit = 10**3
half_limit = limit >> 1
# Euclid's formula
# a = m^2 - n^2, b = 2mn, c = m^2 + n^2 for m > n where (m + n) & 1 == 1 and gcd(m, n) == 1
count = Array.new(half_limit + 1) { 0 } # Perimeter is always even, so save some memory
(1..(-0.5 + Math.sqrt(0.25 + half_limit)).to_i).each do |m| # Solve 2m^2 + 2m = limit
  ((m & 1) + 1).step(m - 1, 2) do |n| # Each number in [1 .. m-1] with different parity
    if gcd(m, n) == 1 # m and n must be coprime
      half_perimeter = m * (m + n) # Collect like terms in a + b + c and then simplify
      half_perimeter.step(half_limit, half_perimeter) do |hp|
        count[hp] += 1
      end
    end
  end
end
max = count.each_with_index.max
puts "count[#{max[1] << 1}] = #{max[0]}"
puts "#{Time.now - t0} s"
