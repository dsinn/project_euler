limit = 99
t0 = Time.now

max_sum = 0
min_digits = 0
limit.downto(2) { |a|
    ab = a ** limit
    if ab.to_s.length < min_digits
        break
    end
    for b in 2 .. limit
        if (s = ab.to_s).length < min_digits
            break
        else
            sum = s.split('').collect { |d| d.to_i }.reduce(:+)
            if max_sum < sum
                max_sum = sum
                min_digits = max_sum / 9
            end
            ab /= a
        end
    end
}

puts max_sum
puts (Time.now - t0).to_s + ' s'