require 'prime'


def is_multiple_of(num, list)
	returner = false
	list.each{ |j|
		returner = true if (num%j == 0)
	}
	return returner
end


def fibonacci(num, max_num = false)
	# Start with 1, 2, ...
	returner = [1, 2]
	i = 3

	while i <= num do
		tmp = returner[-1] + returner[-2]
		break if((max_num) && (max_num <= tmp))

		returner << tmp
		i += 1
	end

	return returner
end


def is_palindrome(check_this)
	check_this = check_this.to_s		# Just in case
	half_leng = check_this.size / 2		# It is rounded down by default

	return check_this[0..(half_leng-1)] == check_this[-(half_leng)..-1].reverse
end





# Problem #1: Multiples of 3 and 5
def multiples_three_and_five(max_num)
	multiple_of = [3, 5]
	start_from = multiple_of.sort[0]

	tmp_array = (start_from..(max_num-1)).select{ |i|
		is_multiple_of(i, multiple_of)
	}
	
	return tmp_array.inject(0){|sum, x| sum + x }
end


# Problem #2: Even Fibonacci numbers
def even_fibonacci_num(max_num)
	fib_list = fibonacci(max_num, max_num).select{ |the_num| the_num%2 == 0 }
	return fib_list.inject(0){ |sum, x| sum + x }
end


# Problem #3: Largest prime factor
def biggest_prime(number)
	number.prime_division.last.first
end


# Problem #4: Largest palindrome product
def largest_palindrome(num_of_digits)
	runner_1 = runner_2 = ('9'*num_of_digits).to_i
	min_min = ('1' + '0'*(num_of_digits-1)).to_i
	min = (runner_1 + min_min) / 3 * 2
	list = []
#	puts runner_2
#	puts min
	
	# Check all likely products
	while ((runner_1 > min) && (runner_2 > min))
		test_this = runner_1 * runner_2
#		puts "#{runner_1} x #{runner_2} = #{test_this}"
		list << test_this if(is_palindrome(test_this))

		# Do next step
		runner_2 -= 1
		if(runner_2 == min)
			runner_1  -= 1
			runner_2 = runner_1
		end
	end

	puts list.sort

	return list.sort.reverse[0]
end


# Problem #5: Smallest multiple
def smallest_multiple_of_list(max_num)
	test_list = []
	# Fidn the smallest list of dividers
	(2..max_num).each{ |num|
		if(Prime.prime?(num))		# Add prime numbers
			test_list << num
		else
			# Try to divide not prime numbers on every 
			# numer in the list -- add waht is left
			runner = num
			test_list.each{ |p_num|
				runner /= p_num if(runner % p_num == 0)
			}
			test_list << runner if(runner > 0)
			test_list.sort!
		end
	}

	return test_list.inject(1){ |num, multi| multi*num }
end


# Problem #6: Sum square difference
def sum_sqr_and_sqr_sum(num_up_to)
	sum_sqr = (1..num_up_to).map{ |num| num* num }.inject(0){ |num, sum| sum + num }

	the_sum = (1..num_up_to).inject(0){ |num, sum| sum + num }
	sqr_sum = the_sum * the_sum

	return sqr_sum - sum_sqr
end


# Problem #7: 10001st prime
def find_prime__by_number(index)
	return Prime.first(index)[-1]
end

# Problem #8: Largest product in a series
def find_n_top_digits(n)
	a_string =   ['73167176531330624919225119674426574742355349194934', '96983520312774506326239578318016984801869478851843',
					'85861560789112949495459501737958331952853208805511', '12540698747158523863050715693290963295227443043557',
					'66896648950445244523161731856403098711121722383113', '62229893423380308135336276614282806444486645238749',
					'30358907296290491560440772390713810515859307960866', '70172427121883998797908792274921901699720888093776',
					'65727333001053367881220235421809751254540594752243', '52584907711670556013604839586446706324415722155397',
					'53697817977846174064955149290862569321978468622482', '83972241375657056057490261407972968652414535100474',
					'82166370484403199890008895243450658541227588666881', '16427171479924442928230863465674813919123162824586',
					'17866458359124566529476545682848912883142607690042', '24219022671055626321111109370544217506941658960408',
					'07198403850962455444362981230987879927244284909188', '84580156166097919133875499200524063689912560717606',
					'05886116467109405077541002256983155200055935729725', '71636269561882670428252483600823257530420752963450']

	the_string = a_string.join('').split('')

	max = 0
	while the_string.size > 0
		do_steps = (n < the_string.size)? (n-1) : (the_string.size-1)
#		puts do_steps

		tmp = the_string[0..do_steps].inject(1){ |multi, i| multi*i.to_i }
#		puts tmp
		max = tmp if(tmp > max)
		the_string.shift()
	end

	return max
end


# Problem #9: Special Pythagorean triplet
def find_pythagorean_triplet_with_sum(the_sum)
	# a^2 < b^2 < c^2   ==>   0 < a << the_sum/sqrt(3)
	# Find all 'a' (and 'b') sutch that:
	# (the_sum^2) / (2the_sum - 2a) is an integer
	list_of_a   = (1..(the_sum/1.7).to_i).select{ |a| the_sum**2 % (2*(the_sum-a)) == 0 }
	# Find all possible 'a' and 'b'
	list_of_ab  = list_of_a.map{ |a| [a, the_sum - (the_sum**2 / (2*(the_sum-a)))] }
	list_of_ab  = list_of_ab.select{ |a, b| a < b }
	# Find all possible 'a', 'b' and 'c'
	list_of_abc = list_of_ab.map{ |a, b| [a, b, Math.sqrt(a**2 + b**2).to_i]}
	list_of_abc = list_of_abc.select{ |a, b, c| b < c }
	list_of_abc = list_of_abc.select{ |a, b, c| a+b+c == the_sum }
#	puts list_of_a.join('; ')
#	puts list_of_b.join('; ')

	list_of_abc.each{ |row| puts row.join(', ')}
	return list_of_abc[0][0] * list_of_abc[0][1] * list_of_abc[0][2] 
end

# Problem #10: Summation of primes
def sum_primes_below(num)
	sum = 0
	Prime.each(num){ |i| sum+=i }
	return sum
end


#==========================================
# Problem #1: Multiples of 3 and 5
#puts multiples_three_and_five(1000)

# Problem #2: Even Fibonacci numbers
#puts even_fibonacci_num(4000000)

# Problem #3: Largest prime factor
#puts biggest_prime(600851475143)

# Problem #4: Largest palindrome product
#puts largest_palindrome(3)

# Problem #5: Smallest multiple
#puts smallest_multiple_of_list(20)

# Problem #6: Sum square difference
#puts sum_sqr_and_sqr_sum(100)

# Problem #7: 10001st prime
#puts find_prime__by_number(10001)

# Problem #8: Largest product in a series
#puts find_n_top_digits(13)

# Problem #9: Special Pythagorean triplet
puts find_pythagorean_triplet_with_sum(1000)

# Problem #10: Summation of primes
#puts sum_primes_below(2000000)