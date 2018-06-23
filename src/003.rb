x = 600851475143
factors = []

# Check if even
while (x & 1 == 0)
    x /= 2
    factors << 2
end

operand = 3
while (x > 1)
    while (x % operand == 0)
        factors << operand
        x /= operand
    end
    operand += 2
end
puts factors.max
