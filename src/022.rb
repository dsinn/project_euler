content = IO.readlines('names.txt')
names = content[0].gsub('"', '').split(',').sort
names.insert(0, '')

sum = 0
names.each_with_index { |name, i|
    score = 0
    name.split('').each { |c|
        score += c.ord - 64
    }
    sum += score * i
}
puts sum
