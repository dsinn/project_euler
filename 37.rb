t0 = Time.now
require_relative 'projecteuler.rb'

def truncatable_prime?(digits)
    if digits.length > 1
        truncatable_prime = true
        number = digits.join('').to_i
        while number > 0
            if not prime? number
                truncatable_prime = false
                break
            end
            number /= 10
        end

        if truncatable_prime
            s = digits.join('')[1 .. -1]
            while s.length > 0
                if not prime? s.to_i
                    truncatable_prime = false
                    break
                end
                s = s[1 .. -1]
            end
        end
    else
        truncatable_prime = false
    end
    truncatable_prime
end

sum = 0
count = 0
len = 1
while count < 11
    sigma_star([1, 3, 7, 9], len).each do |digits|
        if truncatable_prime? digits
            count += 1
            sum += digits.join('').to_i
            puts digits.join('')
        end
        # Might be truncatable if the leading digit is 2 or 5
        digits.insert(0, 2)
        if truncatable_prime? digits
            count += 1
            sum += digits.join('').to_i
            puts digits.join('')
        end
        digits[0] = 5
        if truncatable_prime? digits
            count += 1
            sum += digits.join('').to_i
            puts digits.join('')
        end
        if count >= 11
            break
        end
    end
    len += 1
end

puts 'Sum = ' + sum.to_s
puts (Time.now - t0).to_s + ' s'
