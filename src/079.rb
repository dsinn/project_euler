t0 = Time.now
# Assume no digits are repeated
h = {}

# Track which digits precede the others
IO.readlines("#{__dir__}/keylog.txt").uniq.each do |line|
  digits = line.chomp.split('')

  digits.each do |d|
    h[d] = {} unless h.key? d
  end

  digits.each_with_index do |d, i|
    (0..i - 1).each do |j|
      h[d][digits[j]] = true
    end
  end
end

# Ensure that the hash has every pair.  For example, if the input were [123, 345],
# then h == {1 => {}, 2 => {1}, 3 => {1, 2}, 4 => {3}, 5 => {3, 4}}.
# After the block below is executed,
# h == {1 => {}, 2 => {1}, 3 => {1, 2}, 4 => {1, 2, 3}, 5 => {1, 2, 3, 4}}.
# Note that {1, 2, 3} in my notation actually means {'1'=>true, '2'=>true, '3'=>true}.
# This is not necessary for keylog.txt, but, correctness y'know?
h.each_value do |v|
  keys = v.keys
  keys.each do |k|
    v.merge!(h[k])
  end
end

puts h.sort_by { |_k, v| v.length }.collect { |kv| kv[0] }.join('')
puts "#{Time.now - t0} s"
