squares = Array.new(1000) { |i| i * i }
stop = false
for i in 1 .. 999
    if stop
        break
    end
    for j in i .. (999 - i) / 2
        k = 1000 - i - j
        if squares[i] + squares[j] == squares[k]
            puts i, j, k, i * j * k
            stop = true
            break
        end
    end
end