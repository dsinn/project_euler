t0 = Time.now
require_relative 'projecteuler.rb'

def sortedString(n)
    n.to_s.chars.sort.join
end

is_prime = sieve_atkin(9999)
answer = 0
1001.step(9999, 2) { |i|
    if answer > 0
        break
    elsif is_prime[i]
        2.step((9999 - i) >> 1, 2) { |inc|
            j = i + inc
            k = i + (inc << 1)
            if not (i == 1487 and j == 4817 and k == 8147) and is_prime[j] and is_prime[k]
                s = sortedString(i)
                if s == sortedString(j) and s == sortedString(k)
                    puts i.to_s + j.to_s + k.to_s
                    answer = i + j + k
                end
            end
        }
    end
}

puts answer
puts (Time.now - t0).to_s + ' s'
