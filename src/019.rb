#!/usr/bin/env ruby
days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

starting_year = 1901
ending_year = 2000
remainder_count = 0
remainder_years = (ending_year - starting_year) % 28

total_count = 0
counts_by_starting_day = [
  {},
  {}
]

starting_day = 365 # Skip to January 1, 1901
day = starting_day
year = starting_year

while year <= ending_year
  leap_year_flag = (year % 4).zero? && ((year % 100 > 0) || (year % 400).zero?) ? 1 : 0
  first_day_of_year = day % 7

  if counts_by_starting_day[leap_year_flag].key?(first_day_of_year)
    total_count += counts_by_starting_day[leap_year_flag][first_day_of_year]
    day += 365 + leap_year_flag
  else
    year_count = 0
    (1..12).each do |month|
      year_count += 1 if day % 7 == 6 # 0 is a Monday, therefore 6 is a Sunday

      day += days_in_month[month]
      day += 1 if (month == 2) && (leap_year_flag > 0)
    end

    counts_by_starting_day[leap_year_flag][first_day_of_year] = year_count
    total_count += year_count
  end

  year += 1

  case year - starting_year
  when remainder_years
    remainder_count = total_count
  when 28
    periods_to_skip = (ending_year - year).div(28)
    total_count *= periods_to_skip + 1

    total_count += remainder_count
    year += 28 * periods_to_skip + remainder_years
  end
end

puts total_count
puts counts_by_starting_day
