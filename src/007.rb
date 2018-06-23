require_relative 'projecteuler.rb'

limit = (10001 * 1.2 * Math.log(10001)).floor # Give a bit of leeway since x / ln x is an approximation
is_prime = sieve_atkin(limit)
count = 1
3.step(limit, 2) { |i|
    if is_prime[i]
        count += 1
        if count == 10001
            puts i
            break
        end
    end
}
