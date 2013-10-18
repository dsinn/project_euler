s = (2 ** 1000).to_s
sum = 0
chars = s.split('')
chars.each do |c|
    sum += c.to_i
end
puts sum