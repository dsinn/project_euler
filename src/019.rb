days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

startingYear = 1901
endingYear = 2000
remainderCount = 0
remainderYears = (endingYear - startingYear) % 28

totalCount = 0
countsByStartingDay = [
  {},
  {}
]

startingDay = 365 # Skip to January 1, 1901
day = startingDay
year = startingYear

while year <= endingYear
  leapYearFlag = (year % 4).zero? && ((year % 100 > 0) || (year % 400).zero?) ? 1 : 0
  firstDayOfYear = day % 7

  if countsByStartingDay[leapYearFlag].key?(firstDayOfYear)
    totalCount += countsByStartingDay[leapYearFlag][firstDayOfYear]
    day += 365 + leapYearFlag
  else
    yearCount = 0
    (1..12).each do |month|
      yearCount += 1 if day % 7 == 6 # 0 is a Monday, therefore 6 is a Sunday

      day += days_in_month[month]
      day += 1 if (month == 2) && (leapYearFlag > 0)
    end

    countsByStartingDay[leapYearFlag][firstDayOfYear] = yearCount
    totalCount += yearCount
  end

  year += 1

  case year - startingYear
  when remainderYears
    remainderCount = totalCount
  when 28
    periodsToSkip = (endingYear - year).div(28)
    totalCount *= periodsToSkip + 1

    totalCount += remainderCount
    year += 28 * periodsToSkip + remainderYears
  end
end

puts totalCount
puts countsByStartingDay
