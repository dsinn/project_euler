#!/usr/bin/env ruby
t0 = Time.now
key_length = 3
key_min = 'a'.ord
key_max = 'z'.ord

content = IO.readlines("#{__dir__}/cipher1.txt")
values = content[0].split(',')
buckets = Array.new(key_length) { [] }

def valid?(x)
  # /[A-Za-z0-9 !,;\.\(\)]/
  # <%20>    <!    >    <'()            >    <,    >    <.    >    <0-9            >    <;    >    <A-Z            >    <a-z             >
  [32, 33, 44, 46, 59].include?(x) || [(39..41), (48..57), (65..90), (97..122)].any? { |range| range.include?(x) }
end

buckets.each_with_index do |bucket, i|
  i.step(values.length - 1, key_length) do |j|
    bucket << values[j].to_i
  end
end

sum = 0
key = []
text = Array.new(values.length)
buckets.each_with_index do |bucket, i|
  bucket = buckets[i]
  (key_min..key_max).each do |guess|
    all_english = true
    bucket.each do |char|
      ascii = guess ^ char
      unless valid? ascii
        all_english = false
        break
      end
    end

    next unless all_english

    key << guess

    j = i
    bucket.each_with_index do |char, _i|
      ascii = guess ^ char
      sum += ascii
      text[j] = ascii
      j += key_length
    end

    break
  end
end

puts sum
puts "Key = \"#{key.collect(&:chr).join('')}\""
puts text.collect(&:chr).join('')
puts "#{Time.now - t0} s"
