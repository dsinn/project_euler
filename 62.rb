t0 = Time.now
power10 = 1

answer = -1
base = 0

while answer < 0
    power10 *= 10
    base_limit = ((power10 - 1) ** (1.0 / 3)).floor
    lowest_term = Hash.new
    frequency = Hash.new
    
    for base in base + 1 .. base_limit
        cube = base * base * base
        cube_sorted = cube.to_s.split('').sort.join('')
        
        if not lowest_term.has_key? cube_sorted
            lowest_term[cube_sorted] = cube
        end
        
        if frequency.has_key? cube_sorted
            frequency[cube_sorted] += 1
            if frequency[cube_sorted] == 5
                answer = lowest_term[cube_sorted]
                break
            end
        else
            frequency[cube_sorted] = 1
        end
    end
end

puts answer
puts (Time.now - t0).to_s + ' s'