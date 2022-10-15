#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

numer_product = 1
denom_product = 1
(11..99).each do |numer|
  numer_ones = numer % 10
  next unless numer_ones % 10 > 0

  (numer + 1..99).each do |denom|
    denom_ones = denom % 10
    next unless (denom_ones > 0) && ((numer % 11 > 0) || (denom % 11 > 0))

    numer_tens = numer / 10
    next unless (numer_ones == denom / 10) && (numer.to_f / denom == numer_tens.to_f / denom_ones)

    puts "#{numer}/#{denom}"
    numer_product *= numer
    denom_product *= denom
  end
end

puts denom_product / gcd(numer_product, denom_product)
puts "#{Time.now - t0} s"
