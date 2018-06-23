t0 = Time.now
require_relative 'projecteuler.rb'

is_prime = sieve_atkin(2001000)
max_n = -1
answer = -1
for b in 2 .. 1000
    for a in -1000 .. 1000
        if is_prime[b]
            n = 0
            while is_prime[n * (n + a) + b]
                n += 1
            end
            if max_n < n
                max_n = n
                answer = a * b
            end
        end
    end
end

puts answer
puts (Time.now - t0).to_s + ' s'
