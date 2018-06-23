t0 = Time.now
require_relative 'projecteuler.rb'

is_prime = sieve_atkin(999999)
circular_primes = Hash.new
for len in 2 .. 6
    sigma_star([1, 3, 7, 9], len).each do |digits|
        if not circular_primes.has_key?(digits.join('').to_i)
            is_circular = true
            cache = []
            for i in 1 .. len
                digits << digits.delete_at(0)
                number = digits.join('').to_i
                if not is_prime[number]
                    is_circular = false
                    break
                end
                cache << number
            end

            if is_circular
                puts digits.join('')
                cache.each do |number|
                    circular_primes[number] = true
                end
            end
        end
    end
end

puts circular_primes.length + 4 # There are four single-digit primes
puts (Time.now - t0).to_s + ' s'
