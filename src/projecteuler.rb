$is_prime = {}
$is_prime[1] = false
$is_prime[2] = true
$is_prime[3] = true
def prime?(n)
  if $is_prime.key?(n)
    $is_prime[n]
  elsif (n & 1).zero?
    false
  else
    prime = true
    3.step(Math.sqrt(n).to_i, 2) do |i|
      if prime?(i) && (n % i).zero?
        prime = false
        break
      end
    end
    $is_prime[n] = prime
    prime
  end
end

def arithmetic_series_sum(start, bound, increment)
  start_remainder = start % increment

  bound_remainder = bound % increment
  bound -= bound_remainder - start_remainder
  bound -= increment if bound_remainder < start_remainder

  (start + bound) * ((bound - start) / increment + 1) / 2
end

def get_coprime_digits(a, b)
  # Sieve of Eratosthenes
  isnt_coprime = Array.new(b + 1)
  (a..b).each do |i|
    next if isnt_coprime[i]

    j = i + i
    while j < b
      isnt_coprime[j] = true
      j += i
    end
  end

  coprimes = []
  (a..b).each do |i|
    coprimes << i unless isnt_coprime[i]
  end
  coprimes
end

def gcd(a, b)
  # Euclidean algorithm
  a, b = b, a if a < b

  until b.zero?
    a, b = b, a % b
  end

  a
end

def lcm(a, b)
  a * b / gcd(a, b)
end

def exp10(n)
  product = 1
  (1..n).each do |_i|
    product *= 10
  end
  product
end

def sieve_atkin(limit)
  is_prime = Array.new(limit + 1) { |_i| false }
  sqrt = Math.sqrt(limit).to_i
  (1..sqrt).each do |i|
    i2 = i * i
    (1..sqrt).each do |j|
      j2 = j * j
      n = 4 * i2 + j2
      is_prime[n] = !is_prime[n] if (n <= limit) && ((n % 12 == 1) || (n % 12 == 5))

      n = 3 * i2 + j2
      is_prime[n] = !is_prime[n] if (n <= limit) && (n % 12 == 7)

      next unless i > j

      n = 3 * i2 - j2
      is_prime[n] = !is_prime[n] if (n <= limit) && (n % 12 == 11)
    end
  end

  (5..sqrt).each do |n|
    next unless is_prime[n]

    n2 = n * n
    n2.step(limit, n2) do |k|
      is_prime[k] = false
    end
  end
  is_prime[2] = true
  is_prime[3] = true
  is_prime
end

def get_primes(limit)
  is_prime = sieve_atkin(limit)
  (2..limit).to_a.delete_if { |x| !(is_prime[x]) }
end

def factorial(n)
  if n <= 1
    1
  else
    product = 2
    (3..n).each do |i|
      product *= i
    end
    product
  end
end

def nPr(n, r)
  product = 1
  (n - r + 1..n).each do |i|
    product *= i
  end
  product
end

def nCr(n, r)
  product = nPr(n, r)
  product / factorial(r)
end

def permutations(chars, r, current = [], total = [])
  if r > 0
    r1 = r - 1
    chars.each_with_index do |_char, i|
      chars_clone = Marshal.load(Marshal.dump(chars))
      current_clone = Marshal.load(Marshal.dump(current))
      current_clone << chars_clone.delete_at(i)
      permutations(chars_clone, r1, current_clone, total)
    end
  else
    total << current
  end
  total
end

def combinations(chars, r, i = 0, current = [], total = [])
  if r > 0
    r1 = r - 1
    (i..chars.length - r).each do |j|
      current_clone = Marshal.load(Marshal.dump(current))
      current_clone << chars[j]
      combinations(chars, r1, j + 1, current_clone, total)
    end
  else
    total << current
  end
  total
end

def sigma_star(chars, r, current = [], total = [])
  if r > 0
    r1 = r - 1
    chars.each_with_index do |_char, i|
      current_clone = Marshal.load(Marshal.dump(current))
      current_clone << chars[i]
      sigma_star(chars, r1, current_clone, total)
    end
  else
    total << current
  end
  total
end

def mod_exp(base, exp, mod)
  product = 1
  power = base
  while exp > 0
    product = (product * power) % mod if exp & 1 == 1
    power = (power * power) % mod
    exp >>= 1
  end
  product
end
