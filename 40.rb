t0 = Time.now

def getDigitIndices(limit)
    digitIndex = [0]
    i = 0
    while digitIndex[-1] < limit
        digitIndex << digitIndex[-1] + (i+1) * 9 * 10 ** i
        i += 1
    end
    digitIndex
end

def d(n, digitIndex)
    n -= 1 # Adjust so that the first digit means n = 0
    digitIndex.each_with_index do |index, i|
        if n < index
            diff = n - digitIndex[i - 1]
            number = 10 ** (i - 1) + diff / i
            pos = diff % i
            return number.to_s[pos].to_i
        end
    end
end

digits = 6
digitIndex = getDigitIndices(10 ** digits)
product = 1
power_of_ten = 1
for i in 0 .. digits
    product *= d(power_of_ten, digitIndex)
    if product == 0
        break
    end
    power_of_ten *= 10
end

puts product
puts (Time.now - t0).to_s + ' s'