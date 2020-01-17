content = IO.readlines(__dir__ + '/words.txt')
words = content[0].gsub('"', '').split(',')

triangles = Hash.new
increment = 1
max_computed_triangle = 0

count = 0
words.each do |word|
    score = 0
    word.split('').each do |c|
        score += c.ord - 64
    end

    while max_computed_triangle < score
        max_computed_triangle += increment
        increment += 1
        triangles[max_computed_triangle] = true
    end

    if triangles.has_key?(score)
        count += 1
    end
end
puts count
