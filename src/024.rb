def nthPerm(n, chars)
    if chars.kind_of?(String)
        chars = chars.split('')
    end

    product = 1
    factorials = [1]
    for i in 2 .. chars.length - 1
        product *= i
        factorials << product
    end
    puts factorials

    n -= 1 # n = 0 is the first permutation
    result = ''
    for i in 1 .. factorials.length
        x = factorials.pop
        result += chars.delete_at(n / x).to_s
        n %= x
    end
    result + chars.pop.to_s
end

t0 = Time.now
puts nthPerm(1000000, '0123456789')
puts (Time.now - t0).to_s + ' ms'
