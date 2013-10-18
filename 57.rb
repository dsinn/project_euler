limit = 10 ** 3

t0 = Time.now
p1 = 3
p2 = 7
p_power = 10 ** Math.log10(p2 + 1).ceil
q1 = 2
q2 = 5
q_power = 10 ** Math.log10(q2 + 1).ceil

count = 0
for i in 3 .. limit
    p1, p2 = p2, (p2 << 1) + p1
    q1, q2 = q2, (q2 << 1) + q1
    if p2 >= p_power
        p_power *= 10
    end
    if q2 >= q_power
        q_power *= 10
    end
    if p_power > q_power
        count += 1
    end
end

puts count
puts (Time.now - t0).to_s
