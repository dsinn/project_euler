require_relative 'libs/sum_of_divisors'

limit = 28_123

abundants = SumOfDivisors.generate(limit - 12).map.with_index { |sum, index| index if sum > index }.compact

pair_exists = Array.new(limit + 1) { |_i| false }
abundants.each_with_index do |value, i|
  j = 0
  while (j <= i) && ((pair_sum = value + abundants[j]) <= limit)
    pair_exists[pair_sum] = true
    j += 1
  end
end

puts pair_exists.each_with_index.reduce(0) { |sum, (exists, value)| sum + (exists ? 0 : value) }
