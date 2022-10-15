#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

stop = false
9.downto(1) do |len|
  chars = Array.new(len) do |i|
    len - i
  end
  permutations(chars, len).each do |digits|
    number = digits.join('').to_i
    next unless prime? number

    puts number
    stop = true
    break
  end
  break if stop
end

puts "#{Time.now - t0} s"
