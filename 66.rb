t0 = Time.now
limit = 10 ** 4

def numbers(s)
    a0 = Math.sqrt(s).floor
    
    m = 0
    d = 1
    a = a0
    i = 0
    
    numbers = []
    h = Hash.new
    while not h.has_key? (key = [m, d])
        numbers << a
        h[key] = i
        m = d * a - m
        d = (s - m * m) / d
        a = ((a0 + m) / d).floor        
    end
    numbers
end


puts numbers(14).to_s
puts (Time.now - t0).to_s + ' s'