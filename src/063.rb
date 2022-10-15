iters = 10**4 # Testing

t0 = Time.now
count = 0

(1..iters).each do |_i|
  power_10 = 1
  max_exp = (Math.log(1.0 / 9) / Math.log(0.9)).ceil
  count = 10 * max_exp
  (1..max_exp).each do |exp|
    count -= (power_10**(1.0 / exp)).ceil
    power_10 *= 10
  end
end
puts count

t1 = Time.now
(1..iters).each do |_i|
  count = 0
  (1..9).each do |digit|
    count += (1 / (1 - Math.log10(digit))).floor
  end
end

puts count
puts "#{t1 - t0} s"
puts "#{Time.now - t1} s"
