limit = 10000
d = Array.new(limit + 1) { |n| 1 }

for i in 2 .. limit.div(2)
    (i + i).step(limit - 1, i) { |multiple|
        d[multiple] += i
    }
end

counted = {}
sum = 0
for a in 1 .. limit
    if not counted.key?(a)
        b = d[a]
        if d[b] == a and a != b
            puts a.to_s + ' ' + b.to_s
            sum += a + b
            counted[b] = true
        end
    end
end
puts sum
