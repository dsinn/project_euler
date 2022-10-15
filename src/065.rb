t0 = Time.now
a = [-1, 1, 1]

n = 3
index = 100
index_adjusted = index + 2
while n <= index_adjusted
  a << a[n - 2] + a[n - 1]
  n += 1
  a << a[n - 2] + a[n - 1]
  n += 1
  a << 2 * (n / 3) * a[n - 1] + a[n - 2]
  n += 1
end

puts a[index_adjusted].to_s.split('').collect(&:to_i).reduce(:+)
puts "#{Time.now - t0} s"
