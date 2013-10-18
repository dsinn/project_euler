require 'ostruct'

$is_prime = Hash.new
$is_prime[1] = false
$is_prime[2] = true
$is_prime[3] = true
def prime?(n)
    if $is_prime.has_key?(n)
        $is_prime[n]
    elsif n & 1 == 0
        false
    else
        prime = true
        3.step(Math.sqrt(n).to_i, 2) { |i|
            if prime?(i) and n % i == 0
                prime = false
                break
            end
        }
        $is_prime[n] = prime
        prime
    end
end

def arithmetic_series_sum(start, bound, increment)
    start_remainder = start % increment
    
    bound_remainder = bound % increment
    bound -= bound_remainder - start_remainder
    if (bound_remainder < start_remainder)
        bound -= increment
    end
    
    (start + bound) * ((bound - start) / increment + 1) / 2
end

def get_coprime_digits(a, b)
    # Sieve of Eratosthenes
    isnt_coprime = Array.new(b + 1)
    for i in a .. b
        if !isnt_coprime[i]
            j = i + i
            while j < b
                isnt_coprime[j] = true
                j += i
            end
        end
    end
    
    coprimes = []
    for i in a .. b
        if !isnt_coprime[i]
            coprimes << i
        end
    end
    coprimes
end

def gcd(a, b)
    # Euclidean algorithm
    if a < b
        a, b = b, a
    end
    
    r = [OpenStruct.new(:value => a, :x => 1, :y => 0),
        OpenStruct.new(:value => b, :x => 0, :y => 1)]
    i = 1
    while r[i].value > 0
        i += 1
        q = r[i - 2].value / r[i - 1].value
        r[i] = OpenStruct.new(
            :value => r[i - 2].value % r[i - 1].value,
            :x => r[i - 2].x - q * r[i - 1].x,
            :y => r[i - 2].y - q * r[i - 1].y
        )
    end
    
    r[i - 1]
end

def lcm(a, b)
    a * b / gcd(a, b).value
end

def exp10(n)
    product = 1
    for i in 1 .. n
        product *= 10
    end
    product
end

def sieve_atkin(limit)
    is_prime = Array.new(limit + 1) { |i| false }
    sqrt = Math.sqrt(limit).to_i
    for i in 1 .. sqrt
        i2 = i * i
        for j in 1 .. sqrt
            j2 = j * j
            n = 4 * i2 + j2
            if n <= limit and (n % 12 == 1 or n % 12 == 5)
                is_prime[n] = !is_prime[n]
            end
            
            n = 3 * i2 + j2
            if n <= limit and n % 12 == 7
                is_prime[n] = !is_prime[n]
            end
            
            if i > j
                n = 3 * i2 - j2
                if n <= limit and n % 12 == 11
                    is_prime[n] = !is_prime[n]
                end
            end
        end
    end

    for n in 5 .. sqrt
        if is_prime[n]
            n2 = n * n
            n2.step(limit, n2) { |k|
                is_prime[k] = false
            }
        end
    end
    is_prime[2] = true
    is_prime[3] = true
    is_prime
end

def get_primes(limit)
    is_prime = sieve_atkin(limit)
    (2 .. limit).to_a.delete_if {|x| not is_prime[x]}
end

def factorial(n)
    if n <= 1
        1
    else
        product = 2
        for i in 3 .. n
            product *= i
        end
        product
    end
end

def nPr(n, r)
    product = 1
    for i in n - r + 1 .. n
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
        chars.each_with_index do |char, i|
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
        for j in i .. chars.length - r
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
        chars.each_with_index do |char, i|
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
        if exp & 1 == 1
            product = (product * power) % mod
        end
        power = (power * power) % mod
        exp >>= 1
    end
    product
end