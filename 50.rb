t0 = Time.now
require_relative 'projecteuler.rb'

limit = 10 ** 6
is_prime = sieve_atkin(limit - 1)
primes = [2]
3.step(limit - 1, 2) { |i|
    if is_prime[i]
        primes << i
    end
}

left_sum = 0
width = 0
primes.each_with_index do |p, i|
    left_sum += p
    if left_sum > limit
        width = i
        break
    end
end

answer = -1
while answer < 0
    left_sum -= primes[width]
    sum = left_sum
    
    if is_prime[sum]
        answer = sum
    end    
    for i in 0 .. primes.length - 1 - width
        sum += primes[i + width] - primes[i]
        if sum > limit
            break
        elsif is_prime[sum]
            answer = sum
        end
    end
    width -= 1
end

puts answer
puts (Time.now - t0).to_s + ' s'