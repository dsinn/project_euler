def hasDivisors(x, amount)
    # Inefficient but simple implementation
    total = 1
    # Even numbers first
    while x & 1 == 0
        x >>= 1
        total += 1
    end
    
    # Then odd
    factor = 3
    while x > 1
        count = total
        while x % factor == 0
            total += count
            x /= factor            
        end
        factor += 2
    end
    
    if x > 1
        total += 1
    end
    total >= amount
end

# log2(500).ceil = 9, so find first triangular number at least 2^9 = 512 by solving for n(n+1)/2 = 512
# n^2 + n - 1024 = 0
a = 1
b = 1
c = -1024
n = ((-b + Math.sqrt(b * b - 4 * a * c)) / (2.0 * a)).ceil

sum = n * (n + 1) / 2
while !hasDivisors(sum, 501)
    n += 1
    sum += n
end
puts sum