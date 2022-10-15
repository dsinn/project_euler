#!/usr/bin/env ruby
require_relative 'combinatorics'

puts Combinatorics.factorial(100).to_s.split('').reduce(0) { |sum, char| sum + char.to_i }
