x = 600851475143
factors = []

# Check if even
while (x & 1 == 0)
    x /= 2
    factors << 2
end

operand = 3
sqrt_x = Math.sqrt(x).floor

while (x > 1 && operand < sqrt_x)
    while (x % operand == 0)
        factors << operand
        x /= operand
        sqrt_x = Math.sqrt(x).floor
    end
    operand += 2
end

if x > 1
    factors << x
end

puts factors
