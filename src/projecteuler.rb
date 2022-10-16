def arithmetic_series_sum(start, bound, increment)
  start_remainder = start % increment

  bound_remainder = bound % increment
  bound -= bound_remainder - start_remainder
  bound -= increment if bound_remainder < start_remainder

  (start + bound) * ((bound - start) / increment + 1) / 2
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
