#!/usr/bin/env ruby
t0 = Time.now

def sortString(x)
  x.to_s.split('').sort
end

power_10 = 1
limit = 1

x = power_10
while true
  s = sortString(x)
  x2 = x << 1
  if s == sortString(x2)
    x4 = x2 << 1
    if (s == sortString(x4)) && (s == sortString(x + x2)) && (s == sortString(x + x4)) && (s == sortString(x2 + x4))
      puts x
      break
    end
  end
  x += 1

  next unless x > limit

  power_10 *= 10
  limit = power_10 * 10 / 6
  x = power_10
end

t1 = Time.now
x = 1
while ((s = sortString(x)) != sortString(2 * x)) || (s != sortString(3 * x)) || (s != sortString(4 * x)) || (s != sortString(5 * x)) || (s != sortString(6 * x))
  x += 1
end
puts x

puts "#{t1 - t0} s"
puts "#{Time.now - t1} s"
