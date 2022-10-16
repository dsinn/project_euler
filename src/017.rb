#!/usr/bin/env ruby
WORD_ONES = [
  nil, 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten',
  'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen'
].freeze
WORD_TENS = [nil, nil, 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'].freeze

def english(n)
  return WORD_ONES[n] if n < 20

  if n < 100
    tens = n / 10
    ones = n % 10
    return WORD_TENS[tens] + (ones > 0 ? "-#{WORD_ONES[ones]}" : '')
  end

  if n < 1000
    hundreds = n / 100
    remainder = n % 100
    return "#{WORD_ONES[hundreds]} hundred#{remainder > 0 ? " and #{english(remainder)}" : ''}"
  end

  return "#{english(1)} thousand" if n == 1000

  raise 'Numbers above one thousand not implemented'
end

def count_letters(s)
  s.gsub(/[^a-z]/, '').length
end

puts((1..1000).reduce(0) { |sum, i| sum + count_letters(english(i)) })
