t0 = Time.now
t1 = -1

pents = [1]
increment = 4

pents_hash = {}
pents.each do |p|
  pents_hash[p] = true
end

answer = -1
j_min = 0
k = 1
p = pents[-1]
while (answer < 0) || (increment < answer)
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
    j_min += 1 while pents[j_min] <= min_p
  end

  pents[j_min..k - 1].reverse_each do |p_j|
    diff = p_k - p_j
    next unless pents_hash.key? diff

    sum = p_j + p_k
    while p < sum
      p += increment
      increment += 3
      pents << p
      pents_hash[p] = true
    end

    next unless pents_hash.key? sum

    t1 = Time.now
    answer = diff
    puts "#{p_k} - #{p_j} = #{diff}"
    break
  end
  k += 1
end

puts "#{t1 - t0} s"
puts "#{Time.now - t0} s"
