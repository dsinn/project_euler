def f(x)
  raise 'The spiral cannot have an even width.' if x.even?

  puts (((4 * x + 3) * x + 8) * x - 9) / 6
end
puts f(1001)
