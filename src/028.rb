def f(x)
    if x % 2 == 0
        raise 'The spiral cannot have an even width.'
    end

    puts (((4 * x + 3) * x + 8) * x - 9) / 6
end
puts f(1001)
