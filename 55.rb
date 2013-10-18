limit = 10 ** 4
iters = 50

def palindrome?(n)
    chars = n.to_s.split('')
    for i in 0 .. chars.length - 1 >> 1
        if chars[i] != chars[~i]
            return false
        end
    end
    return true
end

t0 = Time.now
distance = Hash.new # Number's "distance" from a palindrome
count = 0
limit.downto(1) { |n|
    x = n + n.to_s.reverse.to_i
    if distance.has_key? x
        if distance[x] >= iters
            count += 1
        end
    else
        chain = [x]
        while true
            if palindrome? x
                chain.reverse.each_with_index do |x, i|
                    distance[x] = i;
                end
                break
            elsif distance.has_key? x
                current_distance = distance[x]
                chain.reverse.each do |x|
                    distance[x] = current_distance
                    current_distance += 1
                end
                
                if distance[x] >= iters
                    count += 1
                end
                break
            elsif chain.length >= iters
                chain.each do |x|
                    distance[x] = iters + 1
                end
                count += 1
                break
            end
            x += x.to_s.reverse.to_i
            chain << x
        end
    end
}
puts count

t1 = Time.now
# Naive algorithm for comparison
#=begin
count = 0
for n in 1 .. limit
    is_lychrel = true
    x = n
    for i in 1 .. iters
        x += x.to_s.reverse.to_i
        if palindrome? x
            is_lychrel = false
            break
        end
    end
    if is_lychrel
        count += 1
    end
end
puts count
#=end

puts (t1 - t0).to_s + ' s'
puts (Time.now - t1).to_s + ' s'