t0 = Time.now
t1 = -1

pents = [1]
increment = 4

pents_hash = Hash.new
pents.each do |p|
    pents_hash[p] = true
end

answer = -1
j_min = 0
k = 1
p = pents[-1]
while answer < 0 or increment < answer
    # answer > 0 => Correctness checking mode

    p_k = pents[k]
    if p_k.nil?
        p += increment
        increment += 3
        pents << p
        pents_hash[p] = true
        p_k = p
    end

    if answer > 0
        min_p = p_k - answer
        while pents[j_min] <= min_p
            j_min += 1
        end
    end

    pents[j_min .. k - 1].reverse_each do |p_j|
        diff = p_k - p_j
        if pents_hash.has_key? diff
            sum = p_j + p_k
            while p < sum
                p += increment
                increment += 3
                pents << p
                pents_hash[p] = true
            end

            if pents_hash.has_key? sum
                t1 = Time.now
                answer = diff
                puts p_k.to_s + ' - ' + p_j.to_s + ' = ' + diff.to_s
                break
            end
        end
    end
    k += 1
end

puts (t1 - t0).to_s + ' s'
puts (Time.now - t0).to_s + ' s'
