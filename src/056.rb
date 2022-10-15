limit = 99
t0 = Time.now

max_sum = 0
min_digits = 0
limit.downto(2) do |a|
  ab = a**limit
  break if ab.to_s.length < min_digits

  (2..limit).each do |_b|
    if (s = ab.to_s).length < min_digits
      break
    else
      sum = s.split('').collect(&:to_i).reduce(:+)
      if max_sum < sum
        max_sum = sum
        min_digits = max_sum / 9
      end
      ab /= a
    end
  end
end

puts max_sum
puts "#{Time.now - t0} s"
