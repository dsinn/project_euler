limit = 10**3

t0 = Time.now
p1 = 3
p2 = 7
p_power = 10**Math.log10(p2 + 1).ceil
q1 = 2
q2 = 5
q_power = 10**Math.log10(q2 + 1).ceil

count = 0
(3..limit).each do |_i|
  p1, p2 = p2, (p2 << 1) + p1
  q1, q2 = q2, (q2 << 1) + q1
  p_power *= 10 if p2 >= p_power
  q_power *= 10 if q2 >= q_power
  count += 1 if p_power > q_power
end

puts count
puts (Time.now - t0).to_s
