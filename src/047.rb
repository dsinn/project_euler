#!/usr/bin/env ruby
t0 = Time.now
distinct_pfactors = [[-1], [-1], [2]]
primes = [2]

n = 3
loop do
  sqrt = Math.sqrt(n).floor
  primes.each do |p|
    if p > sqrt
      primes << n
      distinct_pfactors << [n]
      break
    elsif (n % p).zero?
      new_pf = distinct_pfactors[n / p]
      unless new_pf.include?(p)
        new_pf = Marshal.load(Marshal.dump(new_pf))
        new_pf << p
      end
      distinct_pfactors << new_pf
      break
    end
  end

  if (distinct_pfactors[-1].length == 4) && (distinct_pfactors[-2].length == 4) && (distinct_pfactors[-3].length == 4) && (distinct_pfactors[-4].length == 4)
    puts distinct_pfactors[-4].join(' ')
    puts distinct_pfactors[-3].join(' ')
    puts distinct_pfactors[-2].join(' ')
    puts distinct_pfactors[-1].join(' ')
    puts n - 3
    break
  end

  n += 1
end
puts "#{Time.now - t0} s"
