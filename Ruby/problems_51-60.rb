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






#==========================================
# Problem #51:
# Problem #52:
# Problem #53:
# Problem #54:
# Problem #55:
# Problem #56:
# Problem #57:
# Problem #58:
# Problem #59:
# Problem #60: