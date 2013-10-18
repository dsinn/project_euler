t0 = Time.now
require_relative 'projecteuler.rb'

stop = false
permutations([8, 7, 6, 5, 4, 3, 2, 1], 8).each do |digits|
    if stop
        break
    end
    
    digits.insert(0, 9)
    right_bound = 0
    s = digits.join('')
    while right_bound <= 4
        operand = s[0 .. right_bound].to_i
        i = right_bound + 1
        n = 2
        success = true
        while i < 9
            product = (n * operand).to_s
            len = product.length
            if product != s[i .. i + len - 1]
                success = false
                break
            end
            n += 1
            i += len
        end
        if success
            puts operand
            puts s
            stop = true
            break
        end
        right_bound += 1
    end
end
puts (Time.now - t0).to_s + ' s'