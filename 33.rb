t0 = Time.now
require_relative 'projecteuler.rb'

numer_product = 1
denom_product = 1
for numer in 11 .. 99
    numer_ones = numer % 10
    if numer_ones % 10 > 0
        for denom in numer+1 .. 99
            denom_ones = denom % 10
            if denom_ones > 0 and (numer % 11 > 0 or denom % 11 > 0)
                numer_tens = numer / 10
                if numer_ones == denom / 10 and numer.to_f / denom.to_f == numer_tens.to_f / denom_ones.to_f
                    puts numer.to_s + '/' + denom.to_s
                    numer_product *= numer
                    denom_product *= denom
                end
            end
        end
    end
end

puts denom_product / gcd(numer_product, denom_product).value
puts (Time.now - t0).to_s + ' s'