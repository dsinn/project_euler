days_in_month = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
count = 0
year = 1900
day = 1

while year < 2001
    for i in 1 .. 12
        if year >= 1901 and day % 7 == 0
            count += 1
        end
        day += days_in_month[i]
        if i == 2 and year % 4 == 0 and (year % 100 > 0 or year % 400 == 0)
            day += 1
        end
    end
    year += 1
end
puts count
