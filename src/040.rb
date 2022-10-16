#!/usr/bin/env ruby
t0 = Time.now

def digit_indices(limit)
  digit_index = [0]
  i = 0
  while digit_index[-1] < limit
    digit_index << digit_index[-1] + (i + 1) * 9 * 10**i
    i += 1
  end
  digit_index
end

def d(n, digit_index)
  n -= 1 # Adjust so that the first digit means n = 0
  digit_index.each_with_index do |index, i|
    next unless n < index

    diff = n - digit_index[i - 1]
    number = 10**(i - 1) + diff / i
    pos = diff % i
    return number.to_s[pos].to_i
  end
end

digits = 6
digit_index = digit_indices(10**digits)
product = 1
power_of_ten = 1
(0..digits).each do |_i|
  product *= d(power_of_ten, digit_index)
  break if product.zero?

  power_of_ten *= 10
end

puts product
puts "#{Time.now - t0} s"
