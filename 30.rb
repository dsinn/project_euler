require_relative 'projecteuler.rb';

t0 = Time.now
digits = [0, 0, 0, 0, 0, 2]
last_index = digits.length - 1
hypercubes = Array.new(10) { |i|
    j = i * i
    j * j * i
}

lenminus = digits.length - 1

total = 0
for i in 2 .. hypercubes[9] * 6
    sum = 0
    digits.each do |digit|
        sum += hypercubes[digit]
    end
    
    if i == sum
        puts i
        total += i
    end
    
    lenminus.downto(0) { |j|
        if digits[j] < 9
            digits[j] += 1
            break
        else
            digits[j] = 0
        end
    }
end
puts total
puts (Time.now - t0).to_s + ' s'