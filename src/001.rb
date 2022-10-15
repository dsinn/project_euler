#!/usr/bin/env ruby
require_relative 'projecteuler'

puts arithmetic_series_sum(3, 999, 3) + arithmetic_series_sum(5, 999, 5) - arithmetic_series_sum(15, 999, 15)
