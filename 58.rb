t0 = Time.now
require_relative 'projecteuler.rb'

x = 1
width = 1
diagonals = 1
increment = 2
primesx10 = 0

while true
    # Odd case
    x += increment
    if prime? x
        primesx10 += 10
    end
    diagonals += 1
    width += 1
    if primesx10 < diagonals
        break
    end

    # Even case
    x += increment
    if prime? x
        primesx10 += 10
    end
    x += increment
    if prime? x
        primesx10 += 10
    end
    x += increment # Bottom-right corner is always a square, which cannot be prime
    diagonals += 3
    increment += 2
    width += 1
    if primesx10 < diagonals
        break
    end
end

puts width
puts (Time.now - t0).to_s + ' s'
