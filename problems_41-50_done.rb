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






# Problem #41: Pandigital prime
def find_largest_pandigital_prime(length)
	return 0 if(length < 1)
	return 1 if(length == 1)

	# Ignore all numbers that are divisible by 3:
	# 1 + 2 + ... + <length> % 3 != 0
	pp_length = (2..length).select{ |len| 
		(1..len).inject(0){ |sum, i| sum+i } % 3 != 0
	}
	return 1 if(pp_length.size < 1)

	return_lenth = pp_length[-1]
	puts "Number length = #{return_lenth}"
	runner_start = (1..return_lenth).to_a.join('')
	runner_end   = runner_start.reverse.to_i

	pp_list = (runner_start.to_i..runner_end)
	Prime.each(10**(return_lenth/2)){ |p|
		pp_list = pp_list.select{ |pp| pp % p != 0 }
	}
	puts "'Half' of all #{return_lenth}digit numbers:    #{pp_list.size}"

	pp_list = pp_list.select{ |pp| is_pandigital(pp) }
	puts "Pandigitals: #{pp_list.size}"
	pp_list = pp_list.select{ |pp| Prime.prime?(pp) }
	return pp_list[-1]
end


# Problem #42: Coded triangle numbers
def triangal_words()
	contents = File.open('./words_p42.txt', 'rb').read.gsub('"', '').gsub(' ', '').upcase.split(',')

	triang = contents.select{ |word| 
		is_triangular(word.bytes.inject(0){ |sum, char| sum + char - 64 })
	}

	return triang.size
#	puts is_triangular(44)
end


# Problem #43: Sub-string divisibility
def pandig_string()
	# We have 10! combinations possible
	proc_adder = Proc.new{ |add, condition, tmp, num, index|
		next unless([add].flatten == [add].flatten.uniq)
		next unless(num - [add].flatten == num)
		next unless(condition)
		to_add = num.clone
		[index].flatten.each_with_index{ |i, ii| 
			to_add[i] = [add].flatten[ii]
		}
		tmp << to_add
	}

	# The returner
	the_nums = []

	# x4x5x6 % 5 ==> x6 == {0, 5}
	the_nums << [nil, nil, nil, nil, nil, 0, nil, nil, nil, nil]
	the_nums << [nil, nil, nil, nil, nil, 5, nil, nil, nil, nil]

	# All special runs are over -- next can be systemized
	cheks = [																		# ADD DIGITS:
				[ 9, Proc.new{ |a, n| a % 2 == 0 },                           3],	# 4: x2x3x4 % 2 ==> x4 % 2
				[98, Proc.new{ |a, n| (a[0] + n[3] + a[1]) % 3 == 0 },   [2, 4]],	# 3, 5: x3x4x5 % 3 ==> x3+x4+x5 % 3
				[ 9, Proc.new { |a, n| (n[4]*10 + n[5] - 2*a) % 7 == 0 },     6],	# 7: x5x6x7 % 7 == > x5x6 - 2*x7 % 7
				[ 9, Proc.new { |a, n| "#{n[5]}#{n[6]}#{a}".to_i % 11 == 0 }, 7],	# 8: x6x7x8 % 11
				[ 9, Proc.new { |a, n| "#{n[6]}#{n[7]}#{a}".to_i % 13 == 0 }, 8],	# 9: x7x8x9 % 13
				[ 9, Proc.new { |a, n| "#{n[7]}#{n[8]}#{a}".to_i % 17 == 0 }, 9],	# 10: x8x9x10 % 17
				[ 9, Proc.new { |a, n| true },                                0], 	# 1: x1 can be any
				[ 9, Proc.new { |a, n| true },                                1]	# 2: x2 can be any
			]

	cheks.each{ |max_num, the_proc, the_index| 
		tmp = []
		the_nums.each{ |num|
			(0..max_num).each{ |add|
				to_add = add
				if(max_num.to_s.size > 1)
					to_add = '0'*(max_num.to_s.size - add.to_s.size) + add.to_s
					to_add = to_add.split('').map{ |a| a.to_i }
				end
				proc_adder.call(to_add, the_proc.call(to_add, num), tmp, num, the_index)
			}
		}
		the_nums = tmp
	}

	the_nums.each{ |num| puts num.join(',') }
	
#	puts '________________'
	returner = the_nums.map{ |row| row.join('').to_i }
	return returner.inject(0){ |sum, num| sum + num.to_i }
end


# Problem #44: Pentagon numbers
def smallest_pent_nums_diff()
	i = 1
	stop = 10000
	pent_nums = []
	returner = nil

	while ((returner == nil) && (stop > 0))
		pent_i = (3*i*i - i) / 2
		pent_nums.each_with_index{ |pent_j, j|
#			pent_j = (3*j*j - j) / 2
			# If difference is a pentagon number
			if(pent_nums.include?(pent_i - pent_j))
#				puts "Testing: #{i} with #{j}"
				check_ij = Math.sqrt(24*(pent_i + pent_j) + 1)
				if((check_ij.to_i == check_ij) && ((check_ij+1) % 6 == 0))
					# We found it
					returner = pent_i - pent_j
				end
			end
		}
		pent_nums << pent_i
		i += 1
		stop -= 1
	end
	return returner
end


# Problem #45: Triangular, pentagonal, and hexagonal
def triang_pent_hex_number()
	returner = nil
	stop = 100000

	trng_nums = (1..stop).map{ |num| (num*num + num)/2 }
	pent_nums = (1..stop).map{ |num| (3*num*num - num)/2 }
	hex_nums  = (1..stop).map{ |num| (2*num*num - num) }

	trng_pent_nums =     (trng_nums - (trng_nums - pent_nums))
	trng_pent_hex_nums = trng_pent_nums - (trng_pent_nums - hex_nums)

	puts trng_pent_hex_nums.join("\n")
	puts "________"

	return trng_pent_hex_nums.size
end


# Problem #46: Goldbach's other conjecture
def goldbach_was_wrong()
	returner = []
	start = 9
	stop = 6000
	primes = Prime.first(stop/2)

	odd_composit = (start..stop).step(2).select{ |num| 
		Prime.prime_division(num).size > 1
	}
#	puts odd_composit.join("\n")
	
	odd_composit.each{ |num| 
#		puts num
		max_primes = primes.select{ |p| p < num }
#		puts max_primes.join(', ')
		chekers = max_primes.map{ |p| Math.sqrt((num-p)/2) }
#		puts chekers.join(', ')
		oups = chekers.select{ |p| p.to_i != p }
		returner << num if(oups.size == chekers.size)
	}

	return returner
end


# Problem #47: Distinct primes factors
def consec_nums_with_prime_factors(digits)
	start = 100000
	stop  = 200000

	# Select all numbers with 2 or more prime dividers
	returner = (start..stop).select{ |num| 
		Prime.prime_division(num).size >= digits
	}

	(digits-1).times{
		returner = returner.select{ |num| 
			returner.include?(num+1)
		}
	}

	returner.each{ |num| 
		puts "#{num}-----"
		Prime.prime_division(num).each{ |p|
			puts "[#{p.join(', ')}]"
		}
		puts "#{num+1}-----"
		Prime.prime_division(num+1).each{ |p|
			puts "[#{p.join(', ')}]"
		}
		puts "#{num+2}-----"
		Prime.prime_division(num+2).each{ |p|
			puts "[#{p.join(', ')}]"
		}
	}

#	return returner
end



# Problem #48: Self powers
def self_power_sum_last_digits(max_num, digits = nil)
	# 10**10 == 10000000000
	# No digits are changed
	runner = (1..max_num).to_a.reject{ |row| row % 10 == 0 }

	runner = runner.map{ |row| row**row }
	if(digits)
		runner = runner.map{ |row| 
			(row.to_s.size > digits)? row.to_s.split('').last(digits).join('').to_i : row
		}
	end
	if((max_num >= 10) && ((digits == nil) || (digits >= 10)))
		runner.push(10**10)
	end
	returner = runner.inject(0){ |sum, row| sum + row }.to_s.split('').last(digits).join('').to_i
	return returner
end


# Problem #49: Prime permutations
def find_prime_permutations(digits)
	return false if(digits < 1)

	# Create a list of all likely numbers of neaded length
	pp_start = 10**(digits-1)
	pp_end   = 10**(digits)-1
	pp_list  = (pp_start..pp_end).to_a

	# Filter only prime numbers
	pp_list = pp_list.select{ |pp| Prime.prime?(pp) }
	puts "Primes:      #{pp_list.size}"

	# Find all distances from one prime number to another one
	distances = {}
	dist_min = 10
	dist_max = (pp_list[-1] - pp_list[0]) / 2

	pp_list.each_with_index{ |value, index| 
		# Check the 'distance' to every next element
		((index+1)..(pp_list.size-1)).each{ |i| 
			dist = pp_list[i] - value
			next if((dist < dist_min) || (dist > dist_max))
			distances[dist] = [] unless(distances[dist])
			distances[dist] << [value, pp_list[i]] if(is_permutation_of(value, pp_list[i]))
		}
	}

	# Do basic cleaning
	puts "Before cleaning:\t#{distances.size}"
	distances = distances.select{ |key, value| value.size > 2 }
	puts "After cleaning: \t#{distances.size}"
	runners = []
	distances.each{ |key, values| 
		values.each{ |a, b| 
			runner = values.select{ |a1, b1| b == a1 }
			if (runner.size > 0)
				runners << runner.flatten.unshift(a).sort.uniq
			end
		}
	}
#	puts runners.size

	return runners
end


# Problem #50: Consecutive prime sum
def sum_of_primes_below_num(num)
	prime_nums = []
	Prime.each(num){ |a| prime_nums << a }
#	puts prime_nums

	cumulative_sum = [0]
	prime_nums.each_with_index{ |value, index| 
		cumulative_sum << cumulative_sum[index] + value
	}

	the_sum = 0
	the_count = 0
	for i in (1..(cumulative_sum.size-1))
		(i-the_count).downto(0).each{ |j| 
#		for j in (0..(i-1))
			tmp = cumulative_sum[i] - cumulative_sum[j]
			break if(tmp >= num)
			if (Prime.prime?(tmp) && (i-j > the_count))
				the_count = i-j
				the_sum = cumulative_sum[i] - cumulative_sum[j]
			end
		}
#		end
	end

	puts "the_sum: #{the_sum}\t\tthe_count: #{the_count}"
	return the_sum
end



#==========================================
# Problem #41: Pandigital prime
#puts find_largest_pandigital_prime(4)

# Problem #42: Coded triangle numbers
#puts triangal_words()

# Problem #43: Sub-string divisibility
#puts pandig_string()

# Problem #44: Pentagon numbers
#puts smallest_pent_nums_diff

# Problem #45: Triangular, pentagonal, and hexagonal
#puts triang_pent_hex_number()

# Problem #46: Goldbach's other conjecture
#puts goldbach_was_wrong()

# Problem #47: Distinct primes factors
puts consec_nums_with_prime_factors(4)

# Problem #48: Self powers
#puts self_power_sum_last_digits(1000, 10)

# Problem #49: Prime permutations
#find_prime_permutations(4).each{ |row| puts row.join(', ') }

# Problem #50: Consecutive prime sum
#puts sum_of_primes_below_num(1000000)