amicable_sum = Array.new(10000) { |i| 0 }

for i in 1 .. amicable_sum.length - 1
    (i + i).step(9999, i) { |j|
        amicable_sum[j] += i
    }
end

double_sum = 0
for a in 1 .. amicable_sum.length - 1
    b = amicable_sum[a]
    if amicable_sum[b] == a and a != b
        puts a.to_s + ' ' + b.to_s
        double_sum += a + b
    end
end
puts double_sum >> 1
