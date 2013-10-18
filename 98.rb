t0 = Time.now

def convert_singleton(s)
    replacements = Hash.new
    code = Array.new(s.length) {0}
    
    distinct = 0
    chars = s.split('')
    chars.each_with_index do |c, i|
        if replacements.has_key? c
            code[i] = replacements[c]
        else
            code[i] = distinct
            replacements[c] = distinct
            distinct += 1
        end
    end
    
    [code, replacements]
end

def convert_from_hash(s, replacements)
    code = Array.new(s.length) {0}
    s.split('').each_with_index do |c, i|
        code[i] = replacements[c]
    end
    code
end

words = IO.readlines('words.txt')[0].split(',').collect {|word| word[1 .. -2]}#.delete_if {|word| word.length > 5}
word_anagram_groups = Array.new(words.max_by {|word| word.length}.length + 1) {[]} # index == length of each string
cache = Hash.new # Cache sorted strings
words.each do |word|
    is_anagram = false
    word_sorted = word.split('').sort
    word_anagram_groups[word.length].each do |group|
        if word_sorted == cache[group[0]]
            group << word
            is_anagram = true
            break
        end
    end
    
    if not is_anagram
        word_anagram_groups[word.length] << [word]
        cache[word] = word_sorted
    end
end

word_anagram_groups.each do |groups|
    groups.delete_if {|group| group.length == 1}
end
word_anagram_groups.delete_if {|groups| groups.empty?}

perm_hashes = []
word_anagram_groups.reverse.each do |groups|
    hash = Hash.new
    perm_hashes << hash
    groups.each do |group|
        group.each_with_index do |word, i|
            temp = convert_singleton(word)
            code = temp[0]
            replacements = temp[1]
            
            if not hash.has_key? code
                hash[code] = Hash.new
            end
            subhash = hash[code]
            
            group.each_with_index do |word2, j|
                if i != j
                    subhash[convert_from_hash(word2, replacements)] = true
                end
            end
        end
    end
end

# Print debug
=begin
word_anagram_groups.each do |groups|
    groups.each do |group|
        puts group.join(' ')
    end
end
perm_hashes.each do |hash|
    hash.each_pair do |k, v|
        puts k.join('') + ' - ' + v.keys.collect {|x| x.join('')}.join(' ')
    end
end
=end

begin
    perm_hashes.each do |hash|
        length = hash.keys.first.length
        
        # Compute all squares of this length in descending order
        squares = Hash.new
        Math.sqrt(10 ** length - 1).floor.downto(Math.sqrt(10 ** (length - 1)).ceil) do |base|
            squares[(base * base).to_s] = true
        end
        
        squares.keys.each do |square|
            temp = convert_singleton(square)
            code = temp[0]
            if hash.has_key? code
                subhash = hash[code]
                subhash.keys.each do |perm|
                    # Construct new number based on the permutation
                    new_number = ''
                    perm.each do |pos|
                        new_number += square[pos]
                    end
                    
                    if squares.has_key? new_number
                        puts square
                        raise ''
                    end
                end
            end
        end
    end
rescue
end

puts (Time.now - t0).to_s + ' s'