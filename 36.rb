t0 = Time.now
digits = 6

def isBinaryPalindrome(decimal)
    binary = decimal.to_s(2)
    is_palindrome = true
    k = binary.length - 1
    for j in 0 .. binary.length >> 1
        if binary[j] != binary[k]
            is_palindrome = false
            break
        end
        k -= 1
    end
    is_palindrome
end

sum = 0
# Even-length decimal palindromes
for i in 1 .. 10 ** (digits >> 1) - 1
    s_i = i.to_s
    decimal = (s_i + s_i.reverse).to_i
    if isBinaryPalindrome(decimal)
        sum += decimal
    end
end

# Odd-length decimal palindromes with more than one digit
for i in 1 .. 10 ** ((digits - 1) >> 1) - 1
    for j in 0 .. 9
        s_i = i.to_s
        decimal = (s_i + j.to_s + s_i.reverse).to_i
        if isBinaryPalindrome(decimal)
            sum += decimal
        end
    end
end

# One-digit decimal palindromes
for i in 1 .. 9
    if isBinaryPalindrome(i)
        sum += i
    end
end

puts sum
puts (Time.now - t0).to_s + ' s'