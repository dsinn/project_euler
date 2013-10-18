t0 = Time.now
require_relative 'projecteuler.rb'

stop = false
9.downto(1) { |len|
    chars = Array.new(len) { |i|
        len - i
    }
    permutations(chars, len).each do |digits|
        number = digits.join('').to_i
        if prime? number
            puts number
            stop = true
            break
        end
    end
    if stop
        break
    end
}

puts (Time.now - t0).to_s + ' s'
