# t^2 + t = 3p^2 - p = 4h^2 - 2h
# t = [-1 + sqrt(16h^2 - 8h + 1)] / 2
#
# n(3n - 1) / 2 = P_n
# 3n^2 - n = 2P_n
# n = [1 + sqrt(1 - 24P_n)] / 6

t0 = Time.now

def is_pentagonal(p_n)
  n = (1 + Math.sqrt(24 * p_n + 1)) / 6
  n == n.to_i
end

answer = -1
h = 144
while answer < 0
  sqrt = Math.sqrt((8 * h) * (2 * h - 1) + 1)
  if sqrt == sqrt.to_i
    h_n = h * (2 * h - 1)
    answer = h_n if is_pentagonal(h * (2 * h - 1))
  end
  h += 1
end

puts answer
puts "#{Time.now - t0} s"
