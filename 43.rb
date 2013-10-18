t0 = Time.now
$primes = [2, 3, 5, 7, 11, 13, 17]
$total = 0

def computeNextDigit(digits)
    if digits.length > 9
        puts digits
        $total += digits.to_i
    else
        prime = $primes[digits.length - 3]
        dividend = digits[-2 .. -1].to_i * 10
        summand = -(dividend % prime)
        if summand < 0
            summand += prime
        end
        
        while summand < 10
            char = summand.to_s
            if digits.index(char).nil?
                computeNextDigit(digits + char)
            end
            summand += prime
        end
    end
end

for i in 0 .. 9
    for j in 0 .. 9
        if i != j
            for k in 0 .. 9
                if i != k and j != k
                    computeNextDigit(i.to_s + j.to_s + k.to_s)
                end
            end
        end
    end
end

puts $total
puts (Time.now - t0).to_s + ' s'