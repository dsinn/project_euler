t0 = Time.now
t1 = -1
require_relative 'projecteuler.rb'

set_size = 4
primes = ['3']
x = 5
complete_graphs = []
min_sum = -1
while min_sum < 0 or complete_graphs.length > 0
    x += 2
    if prime? x
        xs = x.to_s
        
        complete_graphs.each do |graph|
            if min_sum > 0 and graph.collect { |s| s.to_i }.reduce(:+) + (set_size - graph.length) * x >= min_sum
                complete_graphs.delete(graph)
                next
            end
        
            pairwise_prime = true
            graph.each do |p|
                if not prime? (p + xs).to_i or not prime? (xs + p).to_i
                    pairwise_prime = false
                    break
                end
            end
            
            if pairwise_prime
                graph << xs
                if graph.length >= set_size
                    puts graph.join(' ')
                    min_sum = graph.collect { |s| s.to_i }.reduce(:+)
                    t1 = Time.now
                end
            end
        end
        
        primes.each do |p|
            if (min_sum < 0 or p.to_i + (set_size - 1) * x < min_sum) and prime? (p + xs).to_i and prime? (xs + p).to_i
                complete_graphs << [p, xs]
            end
        end
        
        primes << xs
    end
end

complete_graphs.each do |graph|
    puts graph.join(' ')
end
puts min_sum
puts (t1 - t0).to_s + ' s'
puts (Time.now - t0).to_s + ' s'