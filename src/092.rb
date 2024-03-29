#!/usr/bin/env ruby
t0 = Time.now

digits = 7
$squares = (0..9).collect { |x| x * x }
def digits_squared(x)
  sum = 0
  while x > 0
    sum += $squares[x % 10]
    x /= 10
  end
  sum
end

def count(limit, digits = 0, sum = 0)
  count = $eightynine[sum] ? 1 : 0
  if digits < limit
    count += do_recursion(limit, digits + 1, sum) if digits > 0 # Can't have leading zeroes
    (1..9).each do |d|
      count += do_recursion(limit, digits + 1, sum + $squares[d])
    end
  end
  count
end

$eightynine = Array.new($squares[9] * digits + 1)
$eightynine[0] = false
$eightynine[1] = false
$eightynine[89] = true

(2..$eightynine.length - 1).each do |n|
  x = n
  chain = []
  while $eightynine[x].nil?
    chain << x
    x = digits_squared x
  end

  result = $eightynine[x]
  chain.each do |y|
    $eightynine[y] = result
  end
end

puts count(digits)
puts "#{Time.now - t0} s"
