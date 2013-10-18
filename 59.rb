t0 = Time.now
key_length = 3
key_min = 'a'.ord
key_max = 'z'.ord

content = IO.readlines('cipher1.txt')
values = content[0].split(',')
buckets = Array.new(key_length) {[]}

def valid?(x)
    # /[A-Za-z0-9 !,;\.\(\)]/
    # <%20>    <!    >    <'()            >    <,    >    <.    >    <0-9            >    <;    >    <A-Z            >    <a-z             >
    x == 32 or x == 33 or x > 38 and x < 42 or x == 44 or x == 46 or 47 < x and x < 58 or x == 59 or 64 < x and x < 91 or 96 < x and x < 123
end

buckets.each_with_index do |bucket, i|
    i.step(values.length - 1, key_length) { |j|
        bucket << values[j].to_i
    }
end

sum = 0
key = []
text = Array.new(values.length)
buckets.each_with_index do |bucket, i|
    bucket = buckets[i]
    for guess in key_min .. key_max
        all_english = true
        bucket.each do |char|
            ascii = guess ^ char
            if not valid? ascii
                all_english = false
                break
            end
        end
        
        if all_english
            key << guess
            
            j = i
            bucket.each_with_index do |char, i|
                ascii = guess ^ char
                sum += ascii
                text[j] = ascii
                j += key_length
            end
            
            break
        end
    end
end

puts sum
puts 'Key = "' + key.collect { |x| x.chr }.join('') + '"'
puts text.collect { |x| x.chr }.join('')
puts (Time.now - t0).to_s + ' s'