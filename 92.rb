t0 = Time.now

digits = 7
$squares = (0 .. 9).collect {|x| x * x}
def digits_squared(x)
    sum = 0
    while x > 0
        sum += $squares[x % 10]
        x /= 10
    end
    sum
end

def count(limit, digits = 0, sum = 0)
    count = $eightynine[sum] ? 1 : 0
    if digits < limit
        if digits > 0 # Can't have leading zeroes
            count += do_recursion(limit, digits + 1, sum)
        end
        for d in 1 .. 9
            count += do_recursion(limit, digits + 1, sum + $squares[d])
        end
    end
    count
end

$eightynine = Array.new($squares[9] * digits + 1)
$eightynine[0] = false
$eightynine[1] = false
$eightynine[89] = true

for n in 2 .. $eightynine.length - 1
    x = n
    chain = []
    while $eightynine[x].nil?
        chain << x
        x = digits_squared x
    end

    result = $eightynine[x]
    chain.each do |y|
        $eightynine[y] = result
    end
end

puts count(digits)
puts (Time.now - t0).to_s + ' s'
