class SumOfDivisors
  class << self
    def generate(n)
      d = Array.new(n + 1) { |_i| 1 }
      d[0] = 0

      (2..n.div(2)).each do |i|
        (i + i).step(n - 1, i) do |multiple|
          d[multiple] += i
        end
      end

      d
    end
  end
end
