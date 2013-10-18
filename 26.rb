t0 = Time.now
require_relative 'projecteuler.rb'

primes = get_primes(999)
answer = -1
max_len = -1
primes.each do |d|
    h = Hash.new
    place = 0
    numerator = 1
    while numerator > 0
        numerator *= 10
        if h.has_key?(numerator)
            len = place - h[numerator]
            if max_len < len
                max_len = len
                answer = d
            end
            break
        end
        h[numerator] = place
        numerator %= d
        place += 1
    end
end

puts answer
puts (Time.now - t0).to_s + ' ms'
