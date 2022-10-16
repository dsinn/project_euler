#!/usr/bin/env ruby
t0 = Time.now

PRIMES = [2, 3, 5, 7, 11, 13, 17].freeze

$total = 0

def compute_next_digit(digits)
  if digits.length > 9
    puts digits
    $total += digits.to_i
  else
    prime = PRIMES[digits.length - 3]
    dividend = digits[-2..-1].to_i * 10
    summand = -(dividend % prime)
    summand += prime if summand < 0

    while summand < 10
      char = summand.to_s
      compute_next_digit(digits + char) if digits.index(char).nil?
      summand += prime
    end
  end
end

10.times do |i|
  10.times do |j|
    next unless i != j

    10.times do |k|
      compute_next_digit(i.to_s + j.to_s + k.to_s) if (i != k) && (j != k)
    end
  end
end

puts $total
puts "#{Time.now - t0} s"
