collatz_lengths = Hash.new
collatz_lengths[1] = 1
max = 0
answer = -1

3.step(1000000, 2) { |i|
    n = i
    stack = []
    while not collatz_lengths.has_key?(n)
        stack << n
        if n & 1 == 0
            n >>= 1
        else
            n = 3 * n + 1
        end
    end

    len = stack.length + collatz_lengths[n]
    if max < len
        max = len
        answer = i
    end

    # Put computed lengths into array
    for j in 0 .. stack.length - 1
        collatz_lengths[stack[j]] = len
        len -= 1
    end
}

puts answer
puts max
