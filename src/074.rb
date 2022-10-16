#!/usr/bin/env ruby
t0 = Time.now
limit = 10**6 - 1

FACTORIAL = [1, 1, 2, 6, 24, 120, 720, 5040, 40_320, 362_880].freeze

def next_number(x)
  sum = 0
  while x > 0
    sum += FACTORIAL[x % 10]
    x /= 10
  end
  sum
end

distance = {}
(1..limit).each do |n|
  next if distance.key? n

  chain = [n]
  x = n
  loop do
    x = next_number x
    if distance.key? x
      dist = distance[x]
      (chain.length - 1).downto(0) do |j|
        dist += 1
        distance[chain[j]] = dist
      end
      break
    elsif !(i = chain.index(x)).nil?
      (0..i - 1).each do |j|
        distance[chain[j]] = chain.length - j
      end
      loop_length = chain.length - i
      (i..chain.length - 1).each do |j|
        distance[chain[j]] = loop_length
      end
      break
    end
    chain << x
  end
end

puts (1..limit).to_a.select { |n| distance[n] == 60 }.length
puts "#{Time.now - t0} s"
