require 'prime'

FACTORIAL_STORAGE = {}

def factorial(num)
	returner = 1
	if FACTORIAL_STORAGE[num]
		returner = FACTORIAL_STORAGE[num]
	else
		returner = (1..num).inject(1){ |milti, i| milti * i }
		FACTORIAL_STORAGE[num] = returner
	end
	return returner
end


# If the number has all digits from 1 to N
def is_pandigital(num)
	tmp = num.to_s.split('').sort
	checker = tmp.uniq
	return false if(checker.size != tmp.size)
	return false if(checker.size != checker[-1].to_i)

	return checker.join(',') == (1..checker[-1].to_i).to_a.join(',')
end


# Find list of all pythagorean triangles with that perimeter
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

#	list_of_abc.each{ |row| puts row.join(', ')}
	return list_of_abc
end


# Circularly rotate a number
def circular_rotation(num)
	return false if num < 10
	
	tmp = num % 10
	return nil  if tmp == 0
	len = num.to_s.split('').size - 1
	return (num / 10) + (tmp  * (10**len))
end


# Truncate a number left-to-right or right-to-left
def truncate(a_num, right_to_left = true)
	returner = a_num
	if right_to_left
		returner /= 10
	else
		returner = returner.to_s[1..-1].to_i
	end
	return returner
end




# Problem #32: Pandigital products
def stop_smoking()
	rerurner = []

	# 10 digits:
	# *  x **** = ****
	# ** x ***  = ****
	# Smallest 3/4 digit padigitals: 123 / 1234

	for m in (2..99)
		n_start = (m > 9)? 123 : 1234
		n_end = 10000 / m

		for n in (n_start..n_end)
			prod = n*m
			rerurner << prod if(is_pandigital("#{n}#{m}#{prod}"))
		end
	end

	return rerurner.uniq.inject(0){ |sum, i| sum+i }
end




# Problem #34: Digit factorials
def digit_factorial()
	max_digit = factorial(9)
	max_num = 8*max_digit
	runner   = 9
	returner = 0

	while runner < max_num
		runner += 1
		digits = runner.to_s.split('').map(&:to_i).sort().reverse()
		# puts "#{runner} --> #{digits}"
		next if (digits[0] > 5) && (runner < 120)		# !5 = 120
		next if (digits[0] > 6) && (runner < 720)		# !5 = 720
		next if (digits[0] > 7) && (runner < 5040)		# !5 = 5040
		next if (digits[0] > 8) && (runner < 40320)		# !5 = 40320
		next if (digits[0] > 9) && (runner < 362880)	# !5 = 362880

		sum = digits.inject(0){ |sum, i| sum + factorial(i) }
		if runner == sum
			returner += runner
		end
	end
	return returner
end



# Problem #35: Circular primes
def circular_primes(max_num)
	max_digit = max_num.to_s.split('').size
	# Set a dataset as [Number, prime (will be swiched FALSE), curcular (will be swiched TRUE)]
	prime_mask = (0..max_num).map{ |i| [i, true, false] }
	prime_mask[0][1] = false		# Skip 0
	prime_mask[1][1] = false		# Skip 1

	# Get series of prime numbers
	for a_num in (2..max_num-1)		# Skip 0 and 1
		if prime_mask[a_num][1]
#			puts a_num
			# Mask out all divided by 'runner'
			for i in (a_num**2..max_num-1).step(a_num)
				prime_mask[i][1] = false
			end
		end
	end

	# Check for circular primes
	for a_number in prime_mask
		next unless a_number[1]		# Skip not prime
		next if a_number[2]			# Skip checked

		if a_number[0] < 10			# Skip single digit primes
			a_number[2] = true
			next
		end

		tmp_storage = [a_number[0]]
		to_check = a_number[0]
		all_prime = true
		max_digit.times{
			to_check = circular_rotation(to_check)
			break if tmp_storage.include?(to_check)
			tmp_storage << to_check
			if to_check == nil
				all_prime = false
				break
			end
			
			if prime_mask[to_check][1] == false
				all_prime = false
				break
			end
		}
		prime_mask[a_number[0]][2] = all_prime

	end
	
	puts '-----------'
	puts prime_mask.select{ |i, prime, circ| (prime == true) && (circ == true) }.map(&:first).join(', ')
	return prime_mask.select{ |i, prime, circ| (prime == true) && (circ == true) }.size
end



# Problem #37: Truncatable primes
def trunc_primes()
	max_num = 10000000
	prime_mask = Array.new(max_num, true)
	prime_mask[0] = false
	prime_mask[1] = false
	
	# Create a list of prime numbers
	for a_num in (2..max_num-1)
		next unless prime_mask[a_num]		# Skip not prime numbers
		for i in (a_num*a_num..max_num-1).step(a_num)
			prime_mask[i] = false
		end
	end

	# Check the first and the last digit of the primes
	t_primes = prime_mask.clone
	prime_mask.each_with_index{ |a_num, i| 
		# Truncatable right-to-left
		t_primes[i] = false unless [2, 3, 5, 7].include?(i.to_s[0].to_i)
		# Truncatable left-to-right
		t_primes[i] = false unless [3, 5, 7].include?(i % 10)
	}
	t_primes[2] = true		# Small fix

	# Check remeining for truncatable primes
	t_primes.each_with_index{ |a_num, i| 
		next unless a_num
		runner_l = truncate(i, false)
		runner_r = truncate(i)
		while (runner_l > 0) && (runner_r > 0)
			# Check if any truncatable isn't a prime
			unless prime_mask[runner_l]
				t_primes[i] = false
				break
			end
			unless prime_mask[runner_r]
				t_primes[i] = false
				break
			end

			runner_l = truncate(runner_l, false)
			runner_r = truncate(runner_r)
		end
	}

	# 1 digit numbers aren't truncatable
	10.times{ |i| t_primes[i] = false }
	# t_primes.each_with_index{ |val, i| puts "#{i}" if val }

	returner = t_primes.map.with_index{ |val, i| (val)? i : false }.select{ |val| val != false }
	return returner.inject(0){ |sum, val| sum + val }
end



# Problem #38: Pandigital multiples
def largest_pandigital_multi()
	# 5 worked only with '9'. With '9*' 5 is too much.
	multipiers = [1, 2, 3, 4, 5]

	# Parts of the base number
	first_digit = 9	 	# The bigget concat. number must start with 9
	runner = 1
	runner_max = 999	# No more than 4 digits in total (9999)

	max = 918273645		# Given in the example. Result must be bigger.

	while runner < runner_max
		tmp_results = multipiers.map{ |a| a * "#{first_digit}#{runner}".to_i }
		tmp_results.each_with_index{ |a, i|
			check = tmp_results[0..i].join('').to_i
			if((is_pandigital(check)) && (check > max))
				max = check
				puts "#{runner}\t\t#{max}"
				break
			end
		}
		runner += 1
	end

	return max
end



# Problem #39: Integer right triangles
def triangal_max_solutions(max_perimeter)
	the_max = [[20, 48, 52], [24,45,51], [30,40,50]]
	the_perimeter = 120

	(0..max_perimeter).to_a.reverse.each{ |per|
		tmp = find_pythagorean_triplet_with_sum(per)
		if(tmp.size > the_max.size)
			the_max = tmp
			the_perimeter = per
		end
	}
	the_max.each{ |row| puts row.join(', ')}

	return the_perimeter
end



# Problem #40: Champernowne's constant
def sum_of_concat_digits(positions)
	positions = positions.sort
	max_index = positions[-1]
	max_concat = max_index / max_index.to_s.size

	the_concat = '.' + (1..max_index).to_a.join('')

	returner = []
	positions.each{ |digit|
		returner << the_concat[digit].to_i
	}
	puts returner.inject(1){ |multi, i| multi * i }
	return returner
end



#==========================================
# Problem #31

# Problem #32: Pandigital products
#puts stop_smoking()

# Problem #33
# Problem #34: Digit factorials
#puts digit_factorial()

# Problem #35: Circular primes
#puts circular_primes(1000000)

# Problem #36
# Problem #37: Truncatable primes
puts trunc_primes()

# Problem #38: Pandigital multiples
#puts largest_pandigital_multi()

# Problem #39: Integer right triangles
#puts triangal_max_solutions(1000)

# Problem #40: Champernowne's constant
#puts sum_of_concat_digits([1, 10, 100, 1000, 10000, 100000, 1000000])