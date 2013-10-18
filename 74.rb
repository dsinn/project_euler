t0 = Time.now
limit = 10 ** 6 - 1

$factorial = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]
def next_number(x)
    sum = 0
    while x > 0
        sum += $factorial[x % 10]
        x /= 10
    end
    sum
end

distance = Hash.new
for n in 1 .. limit
    if not distance.has_key? n
        chain = [n]
        x = n
        while true
            x = next_number x
            if distance.has_key? x
                dist = distance[x]
                (chain.length - 1).downto(0) do |j|
                    dist += 1
                    distance[chain[j]] = dist
                end
                break
            elsif not (i = chain.index(x)).nil?
                for j in 0 .. i - 1
                    distance[chain[j]] = chain.length - j                    
                end
                loop_length = chain.length - i
                for j in i .. chain.length - 1
                    distance[chain[j]] = loop_length
                end
                break
            end
            chain << x
        end
    end
end

puts (1 .. limit).to_a.select {|n| distance[n] == 60}.length
puts (Time.now - t0).to_s + ' s'