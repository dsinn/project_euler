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

## _More to come when I feel like it..._
