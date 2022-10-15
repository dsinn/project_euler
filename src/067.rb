#!/usr/bin/env ruby
require_relative '018'
triangle = IO.readlines("#{__dir__}/triangle.txt").collect do |line|
  line.split(' ').collect(&:to_i)
end

t0 = Time.now
(2..10**3).each do |_i|
  max_triangle_path_sum(triangle)
end
puts max_triangle_path_sum(triangle)

puts "#{Time.now - t0} s"
