t0 = Time.now

matrix = IO.readlines("#{__dir__}/matrix.txt").collect do |line|
  line.split(',').collect(&:to_i)
end
max_int = 2_147_483_647 # Assume the input values aren't huge

# Assume matrix is not always square, just cuz.
row = matrix[0]
i_max = matrix.length - 1
j_max = row.length - 1

mins = nil
(1..j_max).each do |j|
  mins = Array.new(i_max + 1) { max_int }
  (0..i_max).each do |i1|
    start_sum = matrix[i1][j - 1] + matrix[i1][j]
    mins[i1] = start_sum if mins[i1] > start_sum

    sum = start_sum
    (i1 + 1..i_max).each do |i2|
      sum += matrix[i2][j]
      if mins[i2] > sum
        mins[i2] = sum
      else
        break
      end
    end

    sum = start_sum
    (i1 - 1).downto(0) do |i2|
      sum += matrix[i2][j]
      if mins[i2] > sum
        mins[i2] = sum
      else
        break
      end
    end
  end

  (0..i_max).each do |i|
    matrix[i][j] = mins[i]
  end
end

puts mins.min
puts "#{Time.now - t0} s"
