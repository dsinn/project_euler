#!/usr/bin/env ruby
puts((2 << 999).to_s.split('').reduce(0) { |sum, digit| sum + digit.to_i })
