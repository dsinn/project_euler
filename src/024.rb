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

    n -= 1 # n = 0 is the first permutation
    result = ''
    factorials.reverse.each { |factorial|
        result += chars.delete_at(n / factorial).to_s
        n %= factorial
        puts n
    }
    result + chars.pop.to_s
end

t0 = Time.now
puts nthPerm(1000000, '0123456789')
puts (Time.now - t0).to_s + ' s'
