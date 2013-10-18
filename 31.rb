t0 = Time.now
amount = 200
ways = Array.new(amount + 1) {0}
ways[0] = 1

coins = [1, 2, 5, 10, 20, 50, 100, 200]
coins.each do |coin|
    for i in coin .. amount
        ways[i] += ways[i - coin]
    end
end

puts ways[amount]
puts (Time.now - t0).to_s + ' s'
