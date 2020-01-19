class SumOfDivisors
    class << self
        def generate(n)
            d = Array.new(n + 1) { |i| 1 }
            d[0] = 0

            for i in 2 .. n.div(2)
                (i + i).step(n - 1, i) { |multiple|
                    d[multiple] += i
                }
            end

            d
        end
    end
end
