amicable_sum = Array.new(28124) { |i| 0 }
last_index = amicable_sum.length - 1
for i in 1 .. last_index
    (i + i).step(last_index, i) { |j|
        amicable_sum[j] += i
    }
end

abundants = Hash.new
abundant_max = -1
for i in 1 .. last_index
    if i < amicable_sum[i]
        abundants[i] = true
        abundant_max = i
    end
end

sum = 0
for i in 1 .. abundant_max - 1
    pair_exists = false
    for j in 1 .. i >> 1
        if abundants[j] and abundants[i - j]
            pair_exists = true
            break
        end
    end

    if not pair_exists
        sum += i
    end
end
puts sum
