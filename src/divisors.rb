class Divisors
  @@divisors = {
    1 => { 1 => 1 },
    2 => { 1 => 1, 2 => 1 }
  }
  @@count = {
    1 => 1,
    2 => 2
  }

  class << self
    def count(x)
      return @@count[x] if @@count.key?(x)

      result = checkDivisor(x, 2)
      return result if result

      (3..100).step(2) do |p|
        result = checkDivisor(x, p)
        return result if result
      end

      @@count[x] = 2
      @@divisors[x] = { 1 => 1, x => 1 }
      @@count[x]
    end

    def checkDivisor(x, p)
      return unless (x % p).zero?

      q = x / p

      q_count = count(q)
      divisors = Marshal.load(Marshal.dump(@@divisors[q]))
      if divisors.key?(p)
        divisors[p] += 1
        count = q_count / divisors[p] * (divisors[p] + 1)
      else
        divisors[p] = 1
        count = q_count * 2
      end

      @@count[x] = count
      @@divisors[x] = divisors

      count
    end

    private :checkDivisor
  end
end
