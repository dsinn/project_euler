t0 = Time.now
limit = 100

h = {}
(2..limit).each do |i|
  product = i
  (2..limit).each do |_j|
    product *= i
    h[product] = true
  end
end
puts h.length
puts "#{Time.now - t0} s"
