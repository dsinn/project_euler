t0 = Time.now

matrix = IO.readlines('matrix.txt').collect { |line|
    line.split(',').collect{|x| x.to_i}
}
max_int = 2147483647 # Assume the input values aren't huge

# Assume matrix is not always square, just cuz.
row = matrix[0]
i_max = matrix.length - 1
j_max = row.length - 1

for j in 1 .. j_max
    mins = Array.new(i_max + 1) {max_int}
    for i1 in 0 .. i_max
        start_sum = matrix[i1][j - 1] + matrix[i1][j]
        if mins[i1] > start_sum
            mins[i1] = start_sum
        end

        sum = start_sum
        for i2 in i1 + 1 .. i_max
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

    for i in 0 .. i_max
        matrix[i][j] = mins[i]
    end
end

puts mins.min
puts (Time.now - t0).to_s + ' s'
