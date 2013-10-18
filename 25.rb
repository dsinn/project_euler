term = 2
a = 1
b = 1

limit = 10 ** 999
while b < limit
    a, b = b, a + b
    term += 1
end
puts term