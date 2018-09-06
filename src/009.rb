for a in 1 .. 500
    if (500000 - 1000 * a) % (1000 - a) == 0
        b = (500000 - 1000 * a) / (1000 - a)
        c = 1000 - a - b
        puts a, b, c, a * b * c
        exit
    end
end
