#!/usr/bin/env ruby
(1..500).each do |a|
  next unless ((500_000 - 1000 * a) % (1000 - a)).zero?

  b = (500_000 - 1000 * a) / (1000 - a)
  c = 1000 - a - b
  puts a, b, c, a * b * c
  exit
end
