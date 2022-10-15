limit = 10**4
iters = 50

def palindrome?(n)
  chars = n.to_s.split('')
  (0..chars.length - 1 >> 1).each do |i|
    return false if chars[i] != chars[~i]
  end
  true
end

t0 = Time.now
distance = {} # Number's "distance" from a palindrome
count = 0
limit.downto(1) do |n|
  x = n + n.to_s.reverse.to_i
  if distance.key? x
    count += 1 if distance[x] >= iters
  else
    chain = [x]
    loop do
      if palindrome? x
        chain.reverse.each_with_index do |x, i|
          distance[x] = i
        end
        break
      elsif distance.key? x
        current_distance = distance[x]
        chain.reverse.each do |x|
          distance[x] = current_distance
          current_distance += 1
        end

        count += 1 if distance[x] >= iters
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
end
puts count

t1 = Time.now
# Naive algorithm for comparison
#=begin
count = 0
(1..limit).each do |n|
  is_lychrel = true
  x = n
  (1..iters).each do |_i|
    x += x.to_s.reverse.to_i
    if palindrome? x
      is_lychrel = false
      break
    end
  end
  count += 1 if is_lychrel
end
puts count
#=end

puts "#{t1 - t0} s"
puts "#{Time.now - t1} s"
