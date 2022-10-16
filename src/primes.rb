class Primes
  @@is_prime = {1 => false, 2 => true, 3 => true}

  class << self
    def prime?(n)
      return @@is_prime[n] if @@is_prime.key?(n)
      return false if n.even?

      prime = true
      3.step(Math.sqrt(n).to_i, 2) do |i|
        if prime?(i) && (n % i).zero?
          prime = false
          break
        end
      end
      @@is_prime[n] = prime
    end

    # rubocop:disable all
    def prime_map(limit)
      # Sieve of Atkin
      is_prime = Array.new(limit + 1) { false }
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
    # rubocop:enable all

    def prime_list(limit)
      primes = []
      primes << 2 if limit >= 2

      is_prime = prime_map(limit)
      (3..limit).step(2) { |i| primes << i if is_prime[i] }

      primes
    end
  end
end
