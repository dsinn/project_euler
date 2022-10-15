t0 = Time.now
require_relative 'projecteuler'

def sortedString(n)
  n.to_s.chars.sort.join
end

is_prime = sieve_atkin(9999)
answer = 0
1001.step(9999, 2) do |i|
  if answer > 0
    break
  elsif is_prime[i]
    2.step((9999 - i) >> 1, 2) do |inc|
      j = i + inc
      k = i + (inc << 1)
      if !((i == 1487) && (j == 4817) && (k == 8147)) && is_prime[j] && is_prime[k]
        s = sortedString(i)
        if (s == sortedString(j)) && (s == sortedString(k))
          puts i.to_s + j.to_s + k.to_s
          answer = i + j + k
        end
      end
    end
  end
end

puts answer
puts "#{Time.now - t0} s"
