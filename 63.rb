iters = 10 ** 4 # Testing

t0 = Time.now
for i in 1 .. iters
    power_10 = 1
    max_exp = (Math.log(1.0 / 9) / Math.log(0.9)).ceil
    count = 10 * max_exp
    for exp in 1 .. max_exp
        count -= (power_10 ** (1.0 / exp)).ceil
        power_10 *= 10
    end
end
puts count

t1 = Time.now
for i in 1 .. iters
    count = 0
    for digit in 1 .. 9
        count += (1 / (1 - Math.log10(digit))).floor
    end
end

puts count
puts (t1 - t0).to_s + ' s'
puts (Time.now - t1).to_s + ' s'