require 'bigdecimal'
require 'bigdecimal/math'

def getFibonacciIndex(f_n)
    (BigMath.log(BigDecimal(f_n) * Math.sqrt(5) + 0.5, 10) / Math.log(0.5 + Math.sqrt(1.25))).ceil
end

puts getFibonacciIndex(10 ** 999)
