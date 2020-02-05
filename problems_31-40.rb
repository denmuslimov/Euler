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
# Problem #34:
# Problem #35
# Problem #36
# Problem #37

# Problem #38: Pandigital multiples
#puts largest_pandigital_multi()

# Problem #39: Integer right triangles
puts triangal_max_solutions(1000)

# Problem #40: Champernowne's constant
#puts sum_of_concat_digits([1, 10, 100, 1000, 10000, 100000, 1000000])