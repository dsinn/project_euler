require_relative 'divisors.rb'

limit = 500
sum = 1
increment = 2
loop do
    sum += increment
    increment += 1
    #puts sum.to_s + ' -> ' + Divisors.count(sum).to_s
    if Divisors.count(sum) >= limit
        puts sum
        break
    end
end
