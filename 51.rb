t0 = Time.now
require_relative 'projecteuler.rb'

static_digits_set_by_length = []
index_combos_set_by_length = []
ones = [1, 3, 5, 7]
answer = -1
length = 4
while answer < 0
    # Iterate through possible lengths
    3.step(length, 3) { |replacements|
        # Iterate through number of possible digits in mask
        # Must be multiple of 3, since anything else would result in at least three non-primes (when sum of digits == 3)
        statics = length - replacements
        static_digits_set = static_digits_set_by_length[statics]
        if static_digits_set.nil?
            static_digits_set = sigma_star((0 .. 9).to_a, statics)
            static_digits_set_by_length[statics] = static_digits_set
        end
        
        index_combos_set = index_combos_set_by_length[replacements / 3]
        if index_combos_set.nil?
            index_combos_set = combinations((0 .. length).to_a, replacements)
            index_combos_set_by_length[replacements / 3] = index_combos_set
        end
        
        static_digits_set.each do |static_digits|
            # Iterate through every list of static digits
            index_combos_set.each do |index_combos|
                # Iterate through every combination of mask positions
                ones.each do |one|
                    # Number must end in 1, 3, 7 or 9
                    digits = Marshal.load(Marshal.dump(static_digits))
                    digits << one
                    index_combos.each do |index|
                        digits.insert(index, '*')
                    end
                    
                    primes = 0
                    smallest = -1
                    for i in 0 .. 9
                        index_combos.each do |index|
                            digits[index] = i
                        end
                        if digits[0] > 0 and prime?(digits.join('').to_i)
                            primes += 1
                            if smallest < 0
                                smallest = digits.join('').to_i
                            end
                        end
                        if primes + (10 - i) < 8
                            break
                        end
                    end
                    
                    if primes >= 8
                        if answer < 0 or answer < smallest
                            answer = smallest
                        end
                    end
                end
            end
        end
    }
    length += 1
end

puts answer
puts (Time.now - t0).to_s + ' s'