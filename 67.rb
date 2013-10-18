require_relative '18.rb'
triangle = IO.readlines('triangle.txt').collect { |line|
    line.split(' ').collect{ |x| x.to_i }
}

t0 = Time.now
for i in 2 .. 10 ** 3
    max_triangle_path_sum(triangle)
end
puts max_triangle_path_sum(triangle)

puts (Time.now - t0).to_s + ' s'