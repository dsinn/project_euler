class Combinatorics
    class << self
        def factorial(n)
            return multiplyRange(2, n)
        end

        def nCr(n, r)
            # Minor optimization so that there are fewer operands to multiply depending on how big r is compared to n
            if n.div(r) > 1 then
                return multiplyRange(r + 1, n) / factorial(n - r)
            else
                return nPr(n, r) / factorial(r)
            end
        end

        def nPr(n, r)
            return multiplyRange(n - r + 1, n)
        end

        private

        def multiplyRange(min, max)
            (min..max).reduce(1) { |product, n| product * n }
        end
    end
end
