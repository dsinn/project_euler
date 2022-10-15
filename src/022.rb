#!/usr/bin/env ruby
content = IO.readlines("#{__dir__}/names.txt")
names = content[0].gsub(/[^A-Za-z,]/, '').upcase.split(',').sort
names.insert(0, '')

puts names.each_with_index.reduce(0) { |total_score, (name, rank)|
  total_score + rank * (name.split('').reduce(0) { |name_score, char| name_score + char.ord } - 64 * name.length)
}
