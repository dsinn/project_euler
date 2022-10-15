t0 = Time.now
digits = 6

def isBinaryPalindrome(decimal)
  binary = decimal.to_s(2)
  is_palindrome = true
  k = binary.length - 1
  (0..binary.length >> 1).each do |j|
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
(1..10**(digits >> 1) - 1).each do |i|
  s_i = i.to_s
  decimal = (s_i + s_i.reverse).to_i
  sum += decimal if isBinaryPalindrome(decimal)
end

# Odd-length decimal palindromes with more than one digit
(1..10**((digits - 1) >> 1) - 1).each do |i|
  10.times do |j|
    s_i = i.to_s
    decimal = (s_i + j.to_s + s_i.reverse).to_i
    sum += decimal if isBinaryPalindrome(decimal)
  end
end

# One-digit decimal palindromes
(1..9).each do |i|
  sum += i if isBinaryPalindrome(i)
end

puts sum
puts "#{Time.now - t0} s"
