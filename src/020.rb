require_relative 'combinatorics.rb'

puts Combinatorics.factorial(100).to_s.split('').reduce(0) {|sum, char| sum + char.to_i}
