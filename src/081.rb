t0 = Time.now

matrix = IO.readlines("#{__dir__}/matrix.txt").collect do |line|
  line.split(',').collect(&:to_i)
end

# Assume matrix is not always square, just cuz.
row = matrix[0]
i_max = matrix.length - 1
j_max = row.length - 1

# Prepare first column
sum = row[0]
(1..i_max).each do |i|
  sum += matrix[i][0]
  matrix[i][0] = sum
end

# Prepare first column
sum = row[0]
(1..j_max).each do |j|
  sum += row[j]
  row[j] = sum
end

# DP time
(1..i_max).each do |i|
  prev_row = row
  row = matrix[i]
  (1..j_max).each do |j|
    row[j] += prev_row[j] < row[j - 1] ? prev_row[j] : row[j - 1]
  end
end

puts row[j_max]
puts "#{Time.now - t0} s"
