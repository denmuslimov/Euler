import sys
import math
from functools import reduce


def is_multiple_of(num, list):
	returner = False

	for runner in list:
		if num % runner == 0:
			returner = True
			break
	return returner


def fibonacci(num, max_num = False):
	# Start with 1, 2, ...
	returner = [1, 2]
	i = 3

	while i <= num:
		tmp = returner[-1] + returner[-2]
		if(max_num is not False) and (max_num <= tmp):
			break
		returner.append(tmp)
		i += 1
	return returner


def is_prime(num):
	# Account for all even numbers
	if num == 2: return True
	if num % 2 == 0: return False

	# Account for all odd number
	for div in range(3, int(math.sqrt(num))+1, 2):
		if num % div == 0: return False
	return True


def prime_list(num):
	returner = []
	runner = num

	# Get all '2' out of the way
	while runner % 2 == 0:
		runner //= 2
		returner.append(2)

	# Only odd factors remain
	for i in range(3, int(math.sqrt(runner)+1), 2):
		while runner % i == 0:
			runner /= i
			returner.append(i)

	# What remains, if any, must be a prime number
	if runner > 2:
		returner.append(runner)

	return returner


def is_palindrome(num):
	runner = str(num)

	# Skip middle symbol
	half_len = len(runner) / 2
	half_1st = math.floor(half_len)
	half_2nd = math.ceil(half_len)-1

#	print(num, '(', half_len, '=', half_1st, '/', half_2nd, '):', runner[:half_1st], '<->', runner[:half_2nd:-1])
	return runner[:half_1st] == runner[:half_2nd:-1]




# Problem #1: Multiples of 3 and 5
def multiples_three_and_five(max_num):
	multiple_of = [3, 5]
	tmp_array = range(min(multiple_of), max_num)
	tmp_array = list(\
		filter((lambda x: is_multiple_of(x, multiple_of)),
			   tmp_array)
	)

	return reduce((lambda x, y: x + y), tmp_array)


# Problem #2: Even Fibonacci numbers
def even_fibonacci_num(num):
	even_values = list(filter((lambda x: x % 2 == 0), fibonacci(num, num)))
	return reduce((lambda x, y: x + y), even_values)


# Problem #3: Largest prime factor
def biggest_prime(num):
	return prime_list(num)[-1]


# Problem #4: Largest palindrome product
def largest_palindrome(num):
	runner1 = runner2 = int('9'*num)
	min = int('1' + '0'*(num-1))
	returner = min

	# Check all likely products
	while (runner1 > min) and (runner2 > min):
		test_this = runner1 * runner2
		if (test_this > returner) and (is_palindrome(test_this)):
			returner = test_this

		# Next step
		runner2 -= 1
		if runner2 <= min:
			runner1 -= 1
			runner2 = runner1

	return returner


# Problem #5: Smallest multiple
def smallest_multiple_of_list(max_num):
	return_list = []
	for runner in range(2, max_num+1):
		if is_prime(runner):
			return_list.append(runner)
		else:
			test = runner
			for i in return_list:
				if (test > 1) and (test >= i):
					if test % i == 0:
						test /= i
				else:
					break
			if test > 1: return_list.append(int(test))
			return_list.sort()

	return reduce((lambda x, y: x * y), return_list)


# Problem #6: Sum square difference
def sum_sqr_and_sqr_sum(num):
	sum_sqr = reduce((lambda x, y: x + y), (map((lambda x: x**2), range(1, num+1))))
	sqr_sum = reduce((lambda x, y: x + y), range(1, num+1))**2
	return sqr_sum - sum_sqr


# Problem #7: 10001st prime
def find_prime__by_number(index):
	# Only even prime number
	if index == 1:
		return 2

	avoid_inf = sys.maxsize
	runner = 3
	cur_index = 1
	while runner < avoid_inf:
		if is_prime(runner):
			cur_index += 1
		if cur_index == index:
			break
		runner += 2		# Skip all even numbers
	return runner


# Problem #8: Largest product in a series
def find_n_top_digits(num):
	a_string = ['73167176531330624919225119674426574742355349194934',
				'96983520312774506326239578318016984801869478851843',
				'85861560789112949495459501737958331952853208805511',
				'12540698747158523863050715693290963295227443043557',
				'66896648950445244523161731856403098711121722383113',
				'62229893423380308135336276614282806444486645238749',
				'30358907296290491560440772390713810515859307960866',
				'70172427121883998797908792274921901699720888093776',
				'65727333001053367881220235421809751254540594752243',
				'52584907711670556013604839586446706324415722155397',
				'53697817977846174064955149290862569321978468622482',
				'83972241375657056057490261407972968652414535100474',
				'82166370484403199890008895243450658541227588666881',
				'16427171479924442928230863465674813919123162824586',
				'17866458359124566529476545682848912883142607690042',
				'24219022671055626321111109370544217506941658960408',
				'07198403850962455444362981230987879927244284909188',
				'84580156166097919133875499200524063689912560717606',
				'05886116467109405077541002256983155200055935729725',
				'71636269561882670428252483600823257530420752963450'
			]
	the_string = list(map((lambda x: int(x)), list(''.join(a_string))))

	the_max = 0
	while len(the_string) > num:
		tmp = reduce((lambda x, y: x * y), the_string[0:num])
		# print(the_string[0:num], tmp, the_max, sep='\t\t')
		if the_max < tmp:
			the_max = tmp
		the_string.pop(0)

	return the_max


# Problem #9: Special Pythagorean triplet
def find_pythagorean_triplet_with_sum(the_sum):
	for a in range(1, int(the_sum/3)):
		for b in range(a, int(the_sum/2)):
			c = the_sum - a - b

			if a**2 + b**2 == c**2:
				return [a, b, c, a*b*c]

	return False


# Problem #10: Summation of primes
def the_primes_below(max_num):
	the_sum = 0
	prime_mask = [True]*max_num

	for runner in range(2, max_num):
		if prime_mask[runner]:
			the_sum += runner
			# Mask out all divided by 'runner'
			for i in range(runner**2, max_num, runner):
				prime_mask[i] = False
	return the_sum




# ==========================================
# Problem #1: Multiples of 3 and 5
# print(multiples_three_and_five(1000))

# Problem #2: Even Fibonacci numbers
# print(even_fibonacci_num(4000000))

# Problem #3: Largest prime factor
# print(biggest_prime(600851475143))

# Problem #4: Largest palindrome product
# print(largest_palindrome(3))

# Problem #5: Smallest multiple
# print(smallest_multiple_of_list(20))

# Problem #6: Sum square difference
# print(sum_sqr_and_sqr_sum(100))

# Problem #7: 10001st prime
# print(find_prime__by_number(10001))

# Problem #8: Largest product in a series
# print(find_n_top_digits(13))

# Problem #9: Special Pythagorean triplet
# print(find_pythagorean_triplet_with_sum(1000))

# Problem #10: Summation of primes
print(the_primes_below(2000000))

