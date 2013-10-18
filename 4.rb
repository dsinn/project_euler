require_relative 'projecteuler.rb'

# Assign the next lowest palindrome and return the difference
def next_palindrome_diff(digits)
    lengthminus = digits.length - 1
    middle_pos = lengthminus / 2

    # Start at middle, go left until a non-zero digit is found
    i = middle_pos
    while i >= 0 and digits[i] == 0
        i -= 1
    end

    if i < 0
        return 0
    end

    # Decrement that digit and its palindrome complement
    digits[i] -= 1
    diff = exp10(lengthminus - i);

    complement = lengthminus - i
    if i != complement
        digits[complement] -= 1
        diff += exp10(lengthminus - complement);
    end

    # If number now has leading and trailing zeroes, remove them
    if digits[0] == 0
        digits.pop
        digits.shift
        digits.each_with_index do |v, i|
            digits[i] = 9
        end
        diff = 9 * exp10(lengthminus - 1) + 2
    else
        # Reset the digits between that digit and the middle back to 9
        for j in i + 1 .. middle_pos
            complement = lengthminus - j
            digits[j] = 9;
            diff -= 9 * exp10(lengthminus - j)
            if j != complement
                digits[complement] = 9;
                diff -= 9 * exp10(lengthminus - complement)
            end
        end
    end

    diff
end

def is_divisible_by_triple_digits(x)
    999.downto([100, x / 999].max) { |i|
        if x % i == 0
            j = x / i
            if j >= 100 and j < 1000
                return true
            end
        end
    }
    false
end

t0 = Time.now
x = 997799
digits = []
y = x.to_s
y.split('').each do |c|
    digits << c.to_i
end

count = 0
while x > 0 and !is_divisible_by_triple_digits(x)
    x -= next_palindrome_diff(digits)
    count += 1
end
puts (Time.now - t0).to_s + 'ms'
puts 'Checked ' + count.to_s + ' numbers'
puts x
