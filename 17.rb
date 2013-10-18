$words_ones = [nil, 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen', 'seventeen', 'eighteen', 'nineteen']
$words_tens = [nil, nil, 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety']

def english(n)
    if n < 20
        $words_ones[n]
    elsif n < 100
        tens = n / 10
        ones = n % 10
        $words_tens[tens] + (ones > 0 ? '-' + $words_ones[ones] : '')
    elsif n < 1000
        hundreds = n / 100
        rest = n % 100
        $words_ones[hundreds] + ' hundred' + (rest > 0 ? ' and ' + english(rest) : '')
    elsif n < 1000000
        thousands = n / 1000
        rest = n % 1000
        english(thousands) + ' thousand' + (rest > 0 ? ' ' + english(rest) : '')
    else
        ''
    end
end

def countLetters(s)
    s.gsub(/[^a-z]/, '').length
end

sum = 0
for i in 1 .. 1000
    sum += countLetters(english(i))
end
puts sum

puts english(100)
puts english(105)
puts english(120)
puts english(121)