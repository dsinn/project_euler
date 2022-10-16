#!/usr/bin/env ruby
def divisible_by_triple_digits?(x)
  999.step(Math.sqrt(x).floor, -1 - (x & 1)) do |i|
    if (x % i).zero?
      puts "#{i} x #{x / i} = #{x}"
      return true
    end
  end
  false
end

t0 = Time.now
997.downto(100) do |x|
  y = (x.to_s + x.to_s.reverse).to_i
  break if divisible_by_triple_digits?(y)
end
puts "#{Time.now - t0} s"
