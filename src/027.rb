t0 = Time.now
require_relative 'projecteuler.rb'

is_prime = sieve_atkin(2001000)
max_n = -1
answer = -1
get_primes(1000).each { |b|
    (-b + (b + 1) % 2..1000).step(2) { |a|
        n = 0
        while is_prime[n * (n + a) + b]
            n += 1
        end
        if max_n < n
            max_n = n
            answer = a * b
        end
    }
}

puts answer
puts (Time.now - t0).to_s + ' s'
