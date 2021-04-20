require 'prime'

def factorial(num)
	return (1..num).inject(1){ |milti, i| milti * i }
end


# If the number has all digits from 1 to N
def is_pandigital(num)
	tmp = num.to_s.split('').sort
	checker = tmp.uniq
	return false if(checker.size != tmp.size)
	return false if(checker.size != checker[-1].to_i)

	return checker.join(',') == (1..checker[-1].to_i).to_a.join(',')
end


# If the numbers are permutations of one another
def is_permutation_of(check_num, original_num)
	check_array = check_num.to_s.split('').sort
	orig_array  = original_num.to_s.split('').sort
	return (check_array.join(',') == orig_array.join(','))
end


# Check if the number is triangular
def is_triangular(num)
	return false if(num < 1)

	# Check if sqrt(8num + 1) - 1 % 2 == 0
	sq_root = Math.sqrt(8*num + 1)
	# The number MUST be an int
	return false if(sq_root.to_i != sq_root)

	return (sq_root % 2 != 0)
end


# Create patterns for the problem #51.
# ----------------------------------------------------------
# 3 repeating digits are divided by 3, no matter the digits.
# Any other number of digits isn't stable with remainder of 
# division by 3.
# Thus a series of 8 will have 3 repeating digits.
# ----------------------------------------------------------
# For prime numbers over 10, last digit is 1, 3, 7 or 9.
# Thus the last digit isn't one of the recurring number.
def five_digit_pattern()
	return [
			[1, 0, 0, 0, 1],
			[0, 1, 0, 0, 1],
			[0, 0, 1, 0, 1],
			[0, 0, 0, 1, 1]
		   ]
end
def six_digit_pattern()
	return [
			[1, 1, 0, 0, 0, 1],
			[1, 0, 1, 0, 0, 1],
			[1, 0, 0, 1, 0, 1],
			[1, 0, 0, 0, 1, 1],
			[0, 1, 1, 0, 0, 1],
			[0, 1, 0, 1, 0, 1],
			[0, 1, 0, 0, 1, 1],
			[0, 0, 1, 1, 0, 1],
			[0, 0, 1, 0, 1, 1],
			[0, 0, 0, 1, 1, 1]
		   ]
end



# Problem #51: Prime digit replacements
def prime_digit_replacement()
	returner = 1000000
	# Loop through not repeated digits
	for digits in (11..999).step(2)
		# Sum of 3 repeated digits is divisable by 3
		next if digits % 3 == 0
		# The last digit is 1, 3, 7 or 9
		next if digits % 5 == 0
		
		
		the_patterns = (digits < 100)?  five_digit_pattern() : 
										six_digit_pattern()
		
		for a_pattern in the_patterns
			# Check 'the smallest' members of '8 primes' family
			for repeated_d in (0..2)
				next if ((a_pattern[0] == 0) and (repeated_d == 0))
				
				# Create a number
				to_test = []
				tmp_digits = digits
				for i in a_pattern.reverse()
					if i == 1
						to_test.unshift(tmp_digits % 10)
						tmp_digits /= 10
					else
						to_test.unshift(repeated_d)
					end
				end
				a_number = to_test.inject(0){ |multi, val| multi*10 + val }
#				puts "\t#{a_number}"
				
				# Check for prime
				if (a_number < returner) && (Prime.prime?(a_number))
					# Check for family
					family_size = 0
					for i in (repeated_d..9)
						tmp = to_test.map{ |a| (a == repeated_d)? i : a }
						tmp_num = tmp.inject(0){ |multi, val| multi*10 + val }
						if Prime.prime?(tmp_num)
							family_size += 1
						end
					end
					
					returner = a_number if family_size > 7
					
				end
			end
		end
	end
	return returner
end



# Problem #52: Permuted multiples
def permuted_nums()
	# *2...*6 must have the same digits (and length) as the original.
	# That's why the first character must be 1.
	# And the second character must be less that 7.
	runner = 123455
	max    = 170000
	while runner < max
		runner += 1
		
		mult_count = 1
		(2..6).each{ |mult_num| 
			tmp = runner * mult_num
			
			if !is_permutation_of(tmp, runner)
				break
			end
			if mult_num == 6
				return runner
			end
			mult_count += 1
		}
	end
	puts ''
	return false
end


# Problem #53: Combinatoric selections
def comb_select()
	min_runner = 10
	max_runner = 100
	greater_than = 1000000
	counter = 0
	
	for runner in (min_runner..max_runner)
		run_f = factorial(runner)
		min_select = (runner/4).to_i
		for selection in (2..runner-1)
			divider = factorial(selection) * factorial(runner - selection)
			counter += 1 if run_f / divider > greater_than
		end
	end
	return counter
end



# Problem #57: Square root convergents
def sqrt_convergents()
	the_div = [1, 2]		# Numerator and Denominator
	iterations = 1000
	returner = 0

	while iterations > 0
		# Every next fraction has previouse one in the denominator.
		the_div = [the_div[1], 2*the_div[1] + the_div[0]]		# Simplify the fraction.
		to_test = the_div[0] + the_div[1]						# 1 + fraction
		returner += 1 if to_test.to_s.size > the_div[1].to_s.size
		iterations -= 1
	end
	return returner
end



#==========================================
# Problem #51: Prime digit replacements
#puts prime_digit_replacement()

# Problem #52: Permuted multiples
#puts permuted_nums()

# Problem #53: Combinatoric selections
#puts comb_select()

# Problem #54:
# Problem #55:
# Problem #56:

# Problem #57: Square root convergents
puts sqrt_convergents()

# Problem #58:
# Problem #59:
# Problem #60: