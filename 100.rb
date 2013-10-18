t0 = Time.now
limit = 10 ** 12

a = 15
b = 85

blue_limit = Math.sqrt(0.5) * limit
while a < blue_limit
    a, b = b, 6 * b - a - 2
    puts a
end

puts (Time.now - t0).to_s + ' s'