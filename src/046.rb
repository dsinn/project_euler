t0 = Time.now
double_squares = {}
odd_primes = [3]

last_double_square = 0
n = 5
loop do
  if last_double_square < n
    last_double_square = (double_squares.length + 1) * (double_squares.length + 1) << 1
    double_squares[last_double_square] = true
  end

  # Check if prime/composite
  is_prime = true
  sqrt = Math.sqrt(n).floor
  odd_primes.each do |p|
    if p > sqrt
      break
    elsif (n % p).zero?
      is_prime = false
      break
    end
  end

  if is_prime
    odd_primes << n
  else
    # n is composite, so check the conjecture
    conjecture_holds = false
    odd_primes.each do |p|
      if double_squares.key?(n - p)
        conjecture_holds = true
        break
      end
    end

    unless conjecture_holds
      puts n
      break
    end
  end

  n += 2
end

puts "#{Time.now - t0} s"
