require_relative 'projecteuler.rb'

is_prime = sieve_atkin(2000000)
sum = 2
3.step(2000000, 2) { |i|
    if is_prime[i]
        sum += i
    end
}
puts sum