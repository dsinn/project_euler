# Project Euler solutions

The following are [Project Euler](https://projecteuler.net/archives) solutions that I wrote for fun in early–mid 2013 to familiarize myself with Ruby syntax.

While many others enjoyed writing clever one-liners or using pen and paper, I focused on a compromise between performance, simplicity, and readability.

As much as I enjoyed using LaTeX in university, I'd rather just take advantage of GitHub's markdown renderer and work on a single file instead of working on a file that would be difficult for laymen to follow, then having to render and upload the result, so voilà...

## Problem 1: Multiples of 3 and 5

> If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
>
> Find the sum of all the multiples of 3 or 5 below 1000.

My goal was to compute this in constant time, which can be done by adding the [arithmetic sums](https://en.wikipedia.org/wiki/Arithmetic_progression#Sum) of the 3's and 5's, then subtracting the 15's (lowest common multiple of 3 and 5) to negate the double-counting.

[Source](./src/001.rb)

## Problem 2: Even Fibonacci numbers

> Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
>
> 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
>
> By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

First off, don't use recursion, as it would kill the performance. My goal was to avoid wasting any iterations, _i.e.,_ avoid `if` statements, ternary operators, etc.

Because of the properties of addition with odd and even numbers, every third Fibonacci number is even, so we'd have to keep calculating x<sub>i+3</sub> instead of x<sub>i+1</sub>. If we initialize x<sub>0</sub> = 1 and x<sub>1</sub> = 2, then we'd have to expand x<sub>i+3</sub> = x<sub>i+2</sub> + x<sub>i+1</sub> = ... until we're left with just x<sub>i</sub>, x<sub>i-1</sub> and their coefficients. Collect the like terms, and you're left with:
- x<sub>i+2</sub> = x<sub>i-1</sub> + 2x<sub>i</sub>
- x<sub>i+3</sub> = 2x<sub>i-1</sub> + 3x<sub>i</sub>

It's good to store x<sub>i+2</sub> in a variable for the next iteration.

[Source](./src/002.rb)

## Problem 3: Largest prime factor

> The prime factors of 13195 are 5, 7, 13 and 29.
>
> What is the largest prime factor of the number 600851475143?

My solution was generalized for any number _x,_ and for fun, I stored the entire list of prime factors. In order to optimize memory, you'd just store the last factor found into a scalar variable.

The general idea is to start with the smallest prime number, divide _x_ as much as possible, and then move onto the next smallest prime number until we're done with the prime factorization, _i.e.,_ we've divided _x_ until we're left with 1.

Since 2 is the only even prime number, it gets a special block at the front; the rest of the prime numbers can be found by starting at 3 and incrementing by 2, as they are all odd.

Some odd numbers are a composite number _c,_ but that is okay because we already divided by _c_'s prime factors earlier in the loop since we go through the numbers in ascending order.

Once the operand is past the square root, we know that the only multiples are 1 and the number itself.

An alternative approach would be to generate all the prime numbers up until the square root of _x,_ perhaps using something like the [sieve of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin), but for fun problems like this, I find it less fun to use someone else's algorithm when I'm not smart enough to derive it myself. Some other sieves are simpler, but they are still relatively verbose, I feel.

[Source](./src/003.rb)

## Problem 4: Largest palindrome product

> A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
>
> Find the largest palindrome made from the product of two 3-digit numbers.

My goal was to optimize the search as much as possible. The general idea is to go down the palindromes in descending order, and stop as soon as we find a product of two 3-digit numbers. 999 is the largest 3-digit number, and 999<sup>2</sup> = 998001, so the largest palindrome smaller than that, 997799, is our starting point.

The product verification function basically checks _x_ for a factor _f_ in [100, 999] such that _x_ ÷ _f_ is also in [100, 999]. We can optimize this in three ways:
1. Stop at sqrt(_x_); multiplication is commutative, so going past this would be redoing work.
2. Go in descending order; because we are looking for the largest palindrome, sqrt(_x_) will probably be closer to 999 than to 100.
3. If the palindrome is odd, only check for odd factors, because the product of an even number and any integer is even.

As for generating the next smallest palindrome, we're essentially decrementing the left half by 1, then mirroring it. Instead of simply starting with a 3-digit number and concatenating its reverse string.

[Source](./src/004.rb)

## Problem 5: Smallest multiple

> 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
>
> What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

As per group theory, the lowest common multiple of _a_ and _b_, denoted lcm(_a_, _b_), is _ab_ / gcd(_a_, _b_), where gcd is the greatest common denominator of _a_ and _b_. We use the Euclidean algorithm to efficiently calculate the gcd, then take advantage of the fact that lcm(_a_, _b_, _c_) = lcm(lcm(_a_, _b_), c) and expand for 20 parameters.

[Source](./src/005.rb)

## Problem 6: Sum square difference

> The sum of the squares of the first ten natural numbers is,
>
> 1<sup>2</sup> + 2<sup>2</sup> + ... + 10<sup>2</sup> = 385
>
> The square of the sum of the first ten natural numbers is,
>
> (1 + 2 + ... + 10)<sup>2</sup> = 552 = 3025
>
> Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
>
> Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

For the sum of squares, each new term grows quadratically (1<sup>2</sup> = 1, 2<sup>2</sup> = 4, 3<sup>2</sup> = 9, ... are the values of x<sup>2</sup>), which means the sum grows cubically.  There are various methods to compute the exact cubic equation, but I used the [Lagrange polynomial](https://en.wikipedia.org/wiki/Lagrange_polynomial) with four data points to obtain x<sup>3</sup>/3 + x<sup>2</sup>/2 + x/6.  Because of floating point error, the division should be done last, or you risk computing the wrong answer, so I computed (2x<sup>3</sup> + 3x<sup>2</sup> + x) / 6 instead.

For the square of the sum, the base is just an arithmetic series, so calculate the square of an [arithmetic sum](https://en.wikipedia.org/wiki/Arithmetic_progression#Sum).

Each operand of the subtraction can therefore be computed in constant time, regardless of how many natural numbers you want.

[Source](./src/006.rb)

## Problem 7: 10001st prime

> By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
>
> What is the 10 001st prime number?

As per [Rosser's theorem](https://en.wikipedia.org/wiki/Rosser's_theorem), an upper bound for _π_(_x_) is _x_(log _x_ + log log _x_), so use a high-performance sieve such as [that of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin) to find all of the primes up to it, then count the result up to the 10001st.

[Source](./src/007.rb)

## Problem 8: Largest product in a series

> The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.
> ```
> 73167176531330624919225119674426574742355349194934
> 96983520312774506326239578318016984801869478851843
> 85861560789112949495459501737958331952853208805511
> 12540698747158523863050715693290963295227443043557
> 66896648950445244523161731856403098711121722383113
> 62229893423380308135336276614282806444486645238749
> 30358907296290491560440772390713810515859307960866
> 70172427121883998797908792274921901699720888093776
> 65727333001053367881220235421809751254540594752243
> 52584907711670556013604839586446706324415722155397
> 53697817977846174064955149290862569321978468622482
> 83972241375657056057490261407972968652414535100474
> 82166370484403199890008895243450658541227588666881
> 16427171479924442928230863465674813919123162824586
> 17866458359124566529476545682848912883142607690042
> 24219022671055626321111109370544217506941658960408
> 07198403850962455444362981230987879927244284909188
> 84580156166097919133875499200524063689912560717606
> 05886116467109405077541002256983155200055935729725
> 71636269561882670428252483600823257530420752963450
> ```
>
> Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?

Because the product of any integer and 0 is 0, this can be optimized by splitting by `/0+/` and discarding any substrings of length < 13.

Then, for each of the remaining substrings, compute the product of the first 13 digits, and check if this exceeds the largest product so far. When traversing through the substring, divide the current product by the leftmost digit, multiply by the next digit to the right, and check the max product until you reach the end of the substring.

[Source](./src/008.rb)

## Problem 9: Special Pythagorean triplet

> A Pythagorean triplet is a set of three natural numbers, _a_ < _b_ < _c_, for which,
a<sup>2</sup> + b<sup>2</sup> = c<sup>2</sup>
>
>For example, 32 + 42 = 9 + 16 = 25 = 52.
>
>There exists exactly one Pythagorean triplet for which _a_ + _b_ + _c_ = 1000.
Find the product _abc_.

In order to avoid nested loops, which would hurt performance, we can use some algebra.

Since we're given _a_<sup>2</sup> + _b_<sup>2</sup> = _c_<sup>2</sup> and _a_ + _b_ + _c_ = 100, we can solve for a specific variable in each equation; for example, _c_ = 1000 - _a_ - _b_. After squaring the trinomial and substituting the Pythagorean equation, we have _a_<sup>2</sup> + _b_<sup>2</sup> = 1000000 + _a_<sup>2</sup> + _b_<sup>2</sup> - 2000 _a_ - 2000 _b_ + 2 _ab_. Solve for _b_, and we have _b_ = (500000 - 1000 _a_) / (1000 - _a_).

Since _a_, _b_ and _c_ are integers, the first _a_ such that 1000 - _a_ divides 500000 - 1000 _a_ (the denominator and numerator of _b_, respectively) is the answer.

[Source](./src/009.rb)

## Problem 10: Summation of primes

> The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
>
> Find the sum of all the primes below two million.

Use a high-performance sieve such as [that of Atkin](https://en.wikipedia.org/wiki/Sieve_of_Atkin), then iterate over the result.  Since 2 is the only even prime, a minor optimization can be done by checking only odd numbers.

[Source](./src/010.rb)

## Problem 11: Largest product in a grid

> ```
> 08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
> 49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
> 81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
> 52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
> 22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
> 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
> 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
> 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
> 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
> 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
> 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
> 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
> 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
> 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
> 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
> 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
> 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
> 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
> 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
> 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
> ```
>
> What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?

Brute force: iterate through each row, column, and diagonal. Optimizations similar to Problem #8 could be done, but with only four operands, I didn't bother.

[Source](./src/011.rb)

## Problem 12: Highly divisible triangular number

> The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:
>
> ```
> 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
> ```
>
> Let us list the factors of the first seven triangle numbers:
>
> ```
>  1: 1
>  3: 1,3
>  6: 1,2,3,6
> 10: 1,2,5,10
> 15: 1,3,5,15
> 21: 1,3,7,21
> 28: 1,2,4,7,14,28
> ```
>
> We can see that 28 is the first triangle number to have over five divisors.
>
> What is the value of the first triangle number to have over five hundred divisors?

Since the number of divisors will need to be calculated for a large amount of numbers, [Euler's totient function](https://en.wikipedia.org/wiki/Euler%27s_totient_function) provides a fast way to compute such values, and the function makes use of previous results to improve performance, I wrote a [Divisors class](./src/divisors.rb) for it. With that class doing the heavy lifting, the rest of the script simply iterates through triangle numbers in a fairly memory-efficient manner until a number with a sufficiently large number of divisors is found.

[Source](./src/012.rb)

## Problem 13: Large sum

> Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.
>
> [_Redacted; it's really long, so see [the official page](https://projecteuler.net/problem=13) if you really need to._]

With many languages, the operands are so large that native integers are susceptible to [integer overflow](https://en.wikipedia.org/wiki/Integer_overflow), and floats are used instead, then they are susceptible to [arithmetic underflow](https://en.wikipedia.org/wiki/Arithmetic_underflow). Fortunately for those who used Ruby, that language's integers handle overflow natively.

[Source](./src/013.rb)

## Problem 14: Longest Collatz sequence

> The following iterative sequence is defined for the set of positive integers:
>
> _n_ → _n_/2 (n is even)
> _n_ → 3_n_ + 1 (_n_ is odd)
>
> Using the rule above and starting with 13, we generate the following sequence:
>
> 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
>
> It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
>
> Which starting number, under one million, produces the longest chain?
>
> **NOTE**: Once the chain starts the terms are allowed to go above one million.

Computing the length of the chain for a given number is fairly straightforward, so the main point of interest is the optimization. As we go through a chain, once we encounter a previously seen result, then we can use that result to determine the Collatz chain length of everything from the beginning of the chain up to that point, and cache the new results without having to do any further computation for the remainder of the chain.

[Source](./src/014.rb)

## Problem 15: Lattice paths

> Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
>
> How many such routes are there through a 20×20 grid?

This is a combinatorics problem: you need to go right 20 times and down 20 times; how many different ways are there to do so? In other words, you have to move 40 times, and 20 of those are "right" (or alternatively, 20 of those are "down"), hence the answer is "40 choose 20" or 40! / (20! · 20!). I wrote a [Combinatorics class](./src/combinatorics.rb) to facilitate the computation of factorials, combinations, and [permutations](https://en.wikipedia.org/wiki/Permutation), with some optimizations to reduce the number of multiplication operations since factorial is a linear-time function.

[Source](./src/015.rb)

## Problem 16: Power digit sum

> 2<sup>15</sup> = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
>
> What is the sum of the digits of the number 2<sup>1000</sup>?

Thanks to Ruby's handling of big integers, this is extremely trivial. Compute the power, convert it to a string, convert each character to an integer and sum it up.

- A math-ier solution without strings would be to add the modulo 10's and divide the power by 10 in a loop until the quotient becomes zero; however, in my attempt, it was actually slower than string conversion.
- My solution contains a minor optimization: `2 << 999` is about five times faster than `2 ** 1000`, saving a whopping ~1 μs on my machine.

[Source](./src/016.rb)

## Problem 17: Number letter counts

> If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
>
> If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
>
> **NOTE:** Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

English numbers aren't the most predictable, so we have to split them up into groups such that each member of the group follows the same pattern. I used 1–19, 20–99, 100–999, and 1000, with each group other than the first making use of previous group(s). Thankfully we don't need to go beyond 1000, because figuring out when to include "and" would be more complicated.

[Source](./src/017.rb)

## Problem 18: Maximum path sum I

> By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
>
> ```
>    3
>   7 4
>  2 4 6
> 8 5 9 3
> ```
>
> That is, 3 + 7 + 4 + 9 = 23.
>
> Find the maximum total from top to bottom of the triangle below:
>
> ```
>                      75
>                    95  64
>                   17 47 82
>                 18 35  87 10
>                20 04 82 47 65
>              19 01 23  75 03 34
>             88 02 77 73 07 63 67
>           99 65 04 28  06 16 70 92
>          41 41 26 56 83 40 80 70 33
>        41 48 72 33 47  32 37 16 94 29
>       53 71 44 65 25 43 91 52 97 51 14
>     70 11 33 28 77 73  17 78 39 68 17 57
>    91 71 52 38 17 14 91 43 58 50 27 29 48
>  63 66 04 68 89 53 67  30 73 16 69 87 40 31
> 04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
> ```
>
> **NOTE:** As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)

The clever method they are probably referring to is dynamic programming. Since the path always goes down one row with at most two choices at each step, we can iterate through each row, and store the value of the optimal path up to each node of that row by using the stored optimal values of the previous row. Of course, there is no previous row relative to the first, so we initialize the optimal value of that row as just 75 itself.

[Source](./src/018.rb)

## Problem 19: Counting Sundays

> You are given the following information, but you may prefer to do some research for yourself.
>
> - 1 Jan 1900 was a Monday.
> - Thirty days has September,\
>   April, June and November.\
>   All the rest have thirty-one,\
>   Saving February alone,\
>   Which has twenty-eight, rain or shine.\
>   And on leap years, twenty-nine.
> - A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
>
> How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

Similar to my solution to [Problem 1](#problem-1-multiples-of-3-and-5), while a brute-force solution is already fast, there are certainly opportunities for optimization. In fact, it's possible to compute the answer for any Gregorian year range in constant time, and although I didn't take my solution _that_ far, it does provide the proof of concept that can be extended for a generalized, constant-time solution.

My solution purposely avoids the following, which I've seen others use:
- [Zeller's congruence](https://en.wikipedia.org/wiki/Zeller%27s_congruence), because it's completely unnecessary when we were already told in the problem itself that January 1, 1900, is a Monday.
- Any datetime libraries, because they evade a big chunk of the math aspect in this problem.

Now, let's go over how to count the number of months that start with Sunday. I'm using the `day` variable to store how many days have passed since the beginning of January 1, 1900, so "day 0" is a Monday. That means it's a Sunday whenever `day % 7 == 6`. I also have an array containing the number of days in each month for non–leap years. Since the problem asks us to start counting at year 1901, I skip ahead by summing up the number of days in the aforementioned array (1900 is not a leap year). Here's where the counting begins.

At the beginning of each month, we check `day % 7` and increment the count if it's a Sunday. Then we jump to the 1st of next month by adding the number of days using the array. Add an extra day when it's February on a leap year. In the brute-force approach, this can be done all the way up to the end of the year 2000.

As for the optimizations:
- Optimization 1: Store the number of months that start with Sunday in a 28-year period. A leap year occurs every 4 years and there are 7 days in a week, resulting in a period of `lcm(7, 4) = 28` years. That means January 1 of 1901, 1929, 1957, 1985, etc., are all the same day of the week until after the year 2100, because that is not a leap year as per the rules. Fortunately for this problem, we don't even come close to that, so after counting the number of months that start on a Sunday from 1901–28, we can multiply the count by 3 and skip ahead to 1985. Even if we were to stop the optimizations there, we already cut down the number of months checked from 1200 to 528 (56% reduction).
- Optimization 2: With only the previous optimization, we would have to iterate through each month from 1985 to 2000. This is actually not necessary because 1985–2000 is the same as 1901–1916 (28 × 3 = 84 years before), which we already calculated. If we store the count at the end of 1916, then we can simply add that to the count at the end of 1984 for our final answer. This cuts down the number of month checks to 336 (72% less than the brute force).
- Optimization 3: Cache the count for each day of the week that a year can start with, for both leap years and non–leap years. The process of computing the first 28 years now involves 14 cache hits and 14 cache misses, cutting down the number of month checks by another half to 168 overall (86% less than brute force).

In order to fully generalize this problem and solve it in constant time, similar methods could be used, but you would need special logic to handle optimization 1 around multiples of 100 years until you've counted 2800 years.

[Source](./src/019.rb)

## _More to come when time allows..._
