#!/usr/bin/env ruby
t0 = Time.now

max = 0
max_line = -1
IO.readlines("#{__dir__}/base_exp.txt").collect do |line|
  line.split(',').collect(&:to_i)
end.each_with_index do |values, line_index|
  p_log_base = values[1] * Math.log(values[0])
  if max < p_log_base
    max = p_log_base
    max_line = line_index
  end
end

puts max_line + 1
puts "#{Time.now - t0} s"
