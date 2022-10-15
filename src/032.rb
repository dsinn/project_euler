t0 = Time.now
require_relative 'projecteuler'

pandigitals = {}
for i in 1..(9 - 1) / 3
  j = (9 - i) / 2
    available = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    permutations(available, i).each do |digits1|
      available2 = Marshal.load(Marshal.dump(available))
        digits1.each do |d|
          available2.delete(d)
        end
        s1 = digits1.join('')
        permutations(available2, j).each do |digits2|
          s2 = digits2.join('')
            product = s1.to_i * s2.to_i
            s3 = product.to_s
            if (i + j + s3.length == 9) && !s3.include?('0') && !/(\d)\d*?\1/.match(s1 + s2 + s3)
              puts "#{s1} x #{s2} = #{s3}"
                pandigitals[product] = true
            end
        end
    end
end

sum = 0
pandigitals.each_key do |product|
  sum += product
end

puts sum
puts "#{(Time.now - t0).to_s} s"
