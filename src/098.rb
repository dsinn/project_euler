#!/usr/bin/env ruby
t0 = Time.now

def convert_singleton(s)
  replacements = {}
  code = Array.new(s.length) { 0 }

  distinct = 0
  chars = s.split('')
  chars.each_with_index do |c, i|
    if replacements.key? c
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
  code = Array.new(s.length) { 0 }
  s.split('').each_with_index do |c, i|
    code[i] = replacements[c]
  end
  code
end

words = # .delete_if {|word| word.length > 5}
  IO.readlines("#{__dir__}/words.txt")[0].split(',').collect do |word|
    word[1..-2]
  end
word_anagram_groups = Array.new(words.max_by(&:length).length + 1) { [] } # index == length of each string
cache = {} # Cache sorted strings
words.each do |word|
  is_anagram = false
  word_sorted = word.split('').sort
  word_anagram_groups[word.length].each do |group|
    next unless word_sorted == cache[group[0]]

    group << word
    is_anagram = true
    break
  end

  unless is_anagram
    word_anagram_groups[word.length] << [word]
    cache[word] = word_sorted
  end
end

word_anagram_groups.each do |groups|
  groups.delete_if { |group| group.length == 1 }
end
word_anagram_groups.delete_if(&:empty?)

perm_hashes = []
word_anagram_groups.reverse.each do |groups|
  hash = {}
  perm_hashes << hash
  groups.each do |group|
    group.each_with_index do |word, i|
      temp = convert_singleton(word)
      code = temp[0]
      replacements = temp[1]

      hash[code] = {} unless hash.key? code
      subhash = hash[code]

      group.each_with_index do |word2, j|
        subhash[convert_from_hash(word2, replacements)] = true if i != j
      end
    end
  end
end

# Print debug
# word_anagram_groups.each do |groups|
#     groups.each do |group|
#         puts group.join(' ')
#     end
# end
# perm_hashes.each do |hash|
#     hash.each_pair do |k, v|
#         puts k.join('') + ' - ' + v.keys.collect {|x| x.join('')}.join(' ')
#     end
# end

begin
  perm_hashes.each do |hash|
    length = hash.keys.first.length

    # Compute all squares of this length in descending order
    squares = {}
    Math.sqrt(10**length - 1).floor.downto(Math.sqrt(10**(length - 1)).ceil) do |base|
      squares[(base * base).to_s] = true
    end

    squares.each_key do |square|
      temp = convert_singleton(square)
      code = temp[0]
      next unless hash.key? code

      subhash = hash[code]
      subhash.each_key do |perm|
        # Construct new number based on the permutation
        new_number = ''
        perm.each do |pos|
          new_number += square[pos]
        end

        if squares.key? new_number
          puts square
          raise ''
        end
      end
    end
  end
rescue StandardError
end

puts "#{Time.now - t0} s"
