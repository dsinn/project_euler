def nthPerm(n, chars)
  chars = chars.split('') if chars.is_a?(String)

  product = 1
  factorials = [1]
  (2..chars.length - 1).each do |i|
    product *= i
    factorials << product
  end

  n -= 1 # n = 0 is the first permutation
  result = ''
  factorials.reverse.each do |factorial|
    result += chars.delete_at(n / factorial).to_s
    n %= factorial
    puts n
  end
  result + chars.pop.to_s
end

t0 = Time.now
puts nthPerm(1_000_000, '0123456789')
puts "#{Time.now - t0} s"
