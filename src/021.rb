require_relative 'libs/sum_of_divisors.rb'

limit = 10000
d = SumOfDivisors.generate(limit)

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
