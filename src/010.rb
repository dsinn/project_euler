#!/usr/bin/env ruby
require_relative 'primes'

puts Primes.prime_list(2_000_000).sum
