t0 = Time.now

# Every other triangular number is a hexagonal number, LOL
p = 40755
h = 40755
inc_p = 1 + 3 * 165
inc_h = 1 + 4 * 143

while true
    p += inc_p
    inc_p += 3

    if h < p
        h += inc_h
        inc_h += 4
    end

    if h == p
        puts h
        break
    end
end
puts (Time.now - t0).to_s + ' s'
