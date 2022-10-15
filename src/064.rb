t0 = Time.now
limit = 10**4

def period(s)
  a0 = Math.sqrt(s).floor

  h = {}
  m = 0
  d = 1
  a = a0
  i = 0

  until h.key?(key = [m, d])
    h[key] = i
    i += 1
    m = d * a - m
    d = (s - m * m) / d
    a = ((a0 + m) / d).floor
  end
  i - h[key]
end

square = 0
square_inc = 1
squares = Array.new(Math.sqrt(limit).floor) do
  square += square_inc
  square_inc += 2
  square
end

puts ((1..limit).to_a - squares).reject { |n| (period(n) & 1).zero? }.length
puts "#{Time.now - t0} s"
