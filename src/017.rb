#!/usr/bin/env ruby
$words_ones = [nil, 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve',
               'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
$words_tens = [nil, nil, 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

def english(n)
  if n < 20
    $words_ones[n]
  elsif n < 100
    tens = n / 10
    ones = n % 10
    $words_tens[tens] + (ones > 0 ? "-#{$words_ones[ones]}" : '')
  elsif n < 1000
    hundreds = n / 100
    remainder = n % 100
    "#{$words_ones[hundreds]} hundred#{remainder > 0 ? " and #{english(remainder)}" : ''}"
  elsif n == 1000
    "#{english(1)} thousand"
  else
    raise 'Numbers above one thousand not implemented'
  end
end

def countLetters(s)
  s.gsub(/[^a-z]/, '').length
end

puts((1..1000).reduce(0) { |sum, i| sum + countLetters(english(i)) })
