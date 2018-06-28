def is_divisible_by_triple_digits(x)
    999.step(Math.sqrt(x).floor, -1 - (x & 1)) { |i|
        if x % i == 0
            puts i.to_s + ' x ' + (x / i).to_s + ' = ' + x.to_s
            return true
        end
    }
    false
end

t0 = Time.now
997.downto(100) { |x|
    y = (x.to_s + x.to_s.reverse).to_i
    if is_divisible_by_triple_digits(y)
        break
    end
    x -= 1
}
puts (Time.now - t0).to_s + 'ms'
