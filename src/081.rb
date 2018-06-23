t0 = Time.now

matrix = IO.readlines('matrix.txt').collect { |line|
    line.split(',').collect{|x| x.to_i}
}

# Assume matrix is not always square, just cuz.
row = matrix[0]
i_max = matrix.length - 1
j_max = row.length - 1

# Prepare first column
sum = row[0]
for i in 1 .. i_max
    sum += matrix[i][0]
    matrix[i][0] = sum
end

# Prepare first column
sum = row[0]
for j in 1 .. j_max
    sum += row[j]
    row[j] = sum
end

# DP time
for i in 1 .. i_max
    prev_row = row
    row = matrix[i]
    for j in 1 .. j_max
        row[j] += prev_row[j] < row[j - 1] ? prev_row[j] : row[j - 1]
    end
end

puts row[j]
puts (Time.now - t0).to_s + ' s'
