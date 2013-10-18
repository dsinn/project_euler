a = 1
b = 2
# Use booleans to
a_even = false
b_even = true

sum = 0
while b <= 4000000
    if b_even
        sum += b
    end
    a_even, b_even = b_even, !(a_even ^ b_even)
    a, b = b, a + b
end
puts sum
