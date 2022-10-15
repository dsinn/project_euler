#!/usr/bin/env ruby
t0 = Time.now
require_relative 'projecteuler'

is_prime = sieve_atkin(999_999)
circular_primes = {}
(2..6).each do |len|
  sigma_star([1, 3, 7, 9], len).each do |digits|
    next if circular_primes.key?(digits.join('').to_i)

    is_circular = true
    cache = []
    (1..len).each do |_i|
      digits << digits.delete_at(0)
      number = digits.join('').to_i
      unless is_prime[number]
        is_circular = false
        break
      end
      cache << number
    end

    next unless is_circular

    puts digits.join('')
    cache.each do |number|
      circular_primes[number] = true
    end
  end
end

puts circular_primes.length + 4 # There are four single-digit primes
puts "#{Time.now - t0} s"
