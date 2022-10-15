t0 = Time.now
$primes = [2, 3, 5, 7, 11, 13, 17]
$total = 0

def computeNextDigit(digits)
  if digits.length > 9
    puts digits
    $total += digits.to_i
  else
    prime = $primes[digits.length - 3]
    dividend = digits[-2..-1].to_i * 10
    summand = -(dividend % prime)
    summand += prime if summand < 0

    while summand < 10
      char = summand.to_s
      computeNextDigit(digits + char) if digits.index(char).nil?
      summand += prime
    end
  end
end

10.times do |i|
  10.times do |j|
    next unless i != j

    10.times do |k|
      computeNextDigit(i.to_s + j.to_s + k.to_s) if (i != k) && (j != k)
    end
  end
end

puts $total
puts "#{Time.now - t0} s"
