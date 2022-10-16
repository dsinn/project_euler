#!/usr/bin/env ruby
require_relative 'primes'

t0 = Time.now
t1 = -1

set_size = 4
primes = ['3']
x = 5
complete_graphs = []
min_sum = -1
while (min_sum < 0) || !complete_graphs.empty?
  x += 2
  next unless Primes.prime? x

  xs = x.to_s

  complete_graphs.each do |graph|
    if (min_sum > 0) && (graph.collect(&:to_i).reduce(:+) + (set_size - graph.length) * x >= min_sum)
      complete_graphs.delete(graph)
      next
    end

    pairwise_prime = true
    graph.each do |p|
      if (!Primes.prime? (p + xs).to_i) || (!Primes.prime? (xs + p).to_i)
        pairwise_prime = false
        break
      end
    end

    next unless pairwise_prime

    graph << xs
    next unless graph.length >= set_size

    puts graph.join(' ')
    min_sum = graph.collect(&:to_i).reduce(:+)
    t1 = Time.now
  end

  primes.each do |p|
    if ((min_sum < 0) || (p.to_i + (set_size - 1) * x < min_sum)) && Primes.prime?((p + xs).to_i) && Primes.prime?((xs + p).to_i)
      complete_graphs << [p, xs]
    end
  end

  primes << xs
end

complete_graphs.each do |graph|
  puts graph.join(' ')
end
puts min_sum
puts "#{t1 - t0} s"
puts "#{Time.now - t0} s"
