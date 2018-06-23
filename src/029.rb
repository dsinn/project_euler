t0 = Time.now
limit = 100

h = Hash.new
for i in 2 .. limit
    product = i
    for j in 2 .. limit
        product *= i
        h[product] = true
    end
end
puts h.length
puts (Time.now - t0).to_s + ' s'
