require 'prime'

def factorial(num)
	return (1..num).inject(1){ |milti, i| milti * i }
end

# Check if that number is a sum of its digits in power N
def sum_digit_pow(num, pow)
	runners = num.to_s.split('')

	return num == runners.inject(0){ |sum, i| sum + (i.to_i**pow) }
end





# Problem #24: Lexicographic permutations
def permutation_with_index(nums, index)
	returner = ""
	runners = nums
	remainer = index-1
	n = nums.size

	# Find the first digits that are not in a row
	for i in (1..n)
		j = remainer / factorial(n-i)
		print "j: #{j}\t\trunners: #{runners}\t\t"
		remainer = remainer % factorial(n-i)
		returner += runners[j].to_s
		runners.delete_at(j)
		puts "returner: #{returner}\t\tremainer: #{remainer}"
		break if(remainer == 0)
	end

	# Add the rest
	returner += runners.join('')

	return returner
end



# Problem #28: Number spiral diagonals
def spiral_nums(dimention)
	return -1 if(dimention % 2 == 0)

	returner = [1]
	(2..(dimention-1)).step(2).each{ |num|
		4.times{ returner << returner.last + num }
	}

	return returner.inject(0){ |sum, i| sum + i }
end


# Problem #29; Distinct powers
def distinct_powers(max_a, max_b)
	tmp_a = (2..max_a)
	returner = []

	(2..max_b).each{ |b|
		returner << tmp_a.map{ |a| a**b }
	}

	return returner.flatten.sort.uniq.size
end


# Problem #30: Digit fifth powers
def digit_pow(pow)
	max_digit = 9**pow
	max_num = max_digit.to_s.length * max_digit

	returner = (2..max_num).select{ |the_num| sum_digit_pow(the_num, pow) }

	return returner.inject(0){ |sum, i| sum + i }
end



#==========================================
# Problem #21
# Problem #22
# Problem #23
# Problem #24: Lexicographic permutations
#puts permutation_with_index((0..9).to_a, 1000000)

# Problem #25
# Problem #26
# Problem #27

# Problem #28: Number spiral diagonals
#puts spiral_nums(1001)

# Problem #29; Distinct powers
puts distinct_powers(100, 100)

# Problem #30: Digit fifth powers
#puts digit_pow(5)