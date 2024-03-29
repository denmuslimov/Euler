import math
from functools import reduce


def find_dividers(num):
	returner = [1, num]

	for i in range(2, int(math.sqrt(num)+1)):
		if num % i == 0:
			# Dividers come in pairs.
			# Add both, a found divider and a division result.
			returner.append(i)
			if i*i != num:
				returner.append(int(num/i))
			# returner.extend([i, int(num/i)])
			returner.sort()

	return returner


# Replace CASE
def num_value(num):
	# print('>>', num)
	return {
		1: 3,			# one
		2: 3,			# two
		3: 5,			# three
		4: 4,			# four
		5: 4,			# five
		6: 3,			# six
		7: 5,			# seven
		8: 5,			# eight
		9: 4,			# nine
		10: 3,			# ten
		11: 6,			# eleven
		12: 6,			# twelve
		13: 8,			# thirteen
		14: 8,			# fourteen
		15: 7,			# fifteen
		16: 7,			# sixteen
		17: 9,			# seventeen
		18: 8,			# eighteen
		19: 8,			# nineteen
		20: 6,			# twenty
		30: 6,			# thirty
		40: 5,			# forty
		50: 5,			# fifty
		60: 5,			# sixty
		70: 7,			# seventy
		80: 6,			# eighty
		90: 6,			# ninety
		100: 7,			# hundred
		1000: 8			# thousand
	}.get(num, 0)				# Default value is FALSE


# Return Collatz sequence
def collatz_length(start, cache):
	runner = start
	length = 1

	while runner > 1:
		runner = int(runner/2) if runner % 2 == 0 else runner*3+1

		if runner < start:
			length += cache[runner-1]
			break
		length += 1

	cache[start-1] = length
	return length


# Problem #11: Largest product in a grid
def largest_product_in_a_grid(length):
	the_grid = [[ 8,  2, 22, 97, 38, 15,  0, 40,  0, 75,  4,  5, 7, 78, 52, 12, 50, 77, 91,  8],
				[49, 49, 99, 40, 17, 81, 18, 57, 60, 87, 17, 40, 98, 43, 69, 48, 4, 56, 62,  0],
				[81, 49, 31, 73, 55, 79, 14, 29, 93, 71, 40, 67, 53, 88, 30, 3, 49, 13, 36, 65],
				[52, 70, 95, 23,  4, 60, 11, 42, 69, 24, 68, 56,  1, 32, 56, 71, 37,  2, 36, 91],
				[22, 31, 16, 71, 51, 67, 63, 89, 41, 92, 36, 54, 22, 40, 40, 28, 66, 33, 13, 80],
				[24, 47, 32, 60, 99,  3, 45,  2, 44, 75, 33, 53, 78, 36, 84, 20, 35, 17, 12, 50],
				[32, 98, 81, 28, 64, 23, 67, 10, 26, 38, 40, 67, 59, 54, 70, 66, 18, 38, 64, 70],
				[67, 26, 20, 68,  2, 62, 12, 20, 95, 63, 94, 39, 63,  8, 40, 91, 66, 49, 94, 21],
				[24, 55, 58,  5, 66, 73, 99, 26, 97, 17, 78, 78, 96, 83, 14, 88, 34, 89, 63, 72],
				[21, 36, 23,  9, 75,  0, 76, 44, 20, 45, 35, 14,  0, 61, 33, 97, 34, 31, 33, 95],
				[78, 17, 53, 28, 22, 75, 31, 67, 15, 94,  3, 80,  4, 62, 16, 14,  9, 53, 56, 92],
				[16, 39,  5, 42, 96, 35, 31, 47, 55, 58, 88, 24,  0, 17, 54, 24, 36, 29, 85, 57],
				[86, 56,  0, 48, 35, 71, 89,  7,  5, 44, 44, 37, 44, 60, 21, 58, 51, 54, 17, 58],
				[19, 80, 81, 68,  5, 94, 47, 69, 28, 73, 92, 13, 86, 52, 17, 77,  4, 89, 55, 40],
				[ 4, 52, 8, 83, 97, 35, 99, 16,   7, 97, 57, 32, 16, 26, 26, 79, 33, 27, 98, 66],
				[88, 36, 68, 87, 57, 62, 20, 72,  3, 46, 33, 67, 46, 55, 12, 32, 63, 93, 53, 69],
				[ 4, 42, 16, 73, 38, 25, 39, 11, 24, 94, 72, 18,  8, 46, 29, 32, 40, 62, 76, 36],
				[20, 69, 36, 41, 72, 30, 23, 88, 34, 62, 99, 69, 82, 67, 59, 85, 74,  4, 36, 16],
				[20, 73, 35, 29, 78, 31, 90,  1, 74, 31, 49, 71, 48, 86, 81, 16, 23, 57,  5, 54],
				[ 1, 70, 54, 71, 83, 51, 54, 69, 16, 92, 33, 48, 61, 43, 52,  1, 89, 19, 67, 48]]

	hor_max = 0
	ver_max = 0
	# Horizontal --
	for row in the_grid:
		# Use a window that is <column_count - LENGTH> wide
		# to create all possible combinations of LENGTH next numbers
		hor_runner = row[length-1:]
		for i in range(length-1):
			hor_runner = list(map((lambda x: x[0]*x[1]), zip(hor_runner, row[i:-length+i+1])))

		if hor_max < max(hor_runner):
			hor_max = max(hor_runner)

	# Vertical |
	for col in zip(*the_grid):
		# Use a window that is <row_count - LENGTH> wide
		# to create all possible combinations of LENGTH next numbers
		ver_runner = col[length-1:]		# Last of these arrays
		for j in range(length-1):
			ver_runner = list(map((lambda x: x[0]*x[1]), zip(ver_runner, col[j:-length+j+1])))

		if ver_max < max(ver_runner):
			ver_max = max(ver_runner)

	d1_max = 0
	d2_max = 0
	rows = len(the_grid)
	cols = len(the_grid[0])
	print(rows, 'x', cols)
	for i in range(rows):
		for j in range(cols):
			# Diagonal \
			# Skip last LENGTH rows and columns
			if (i <= rows-length) and (j <= cols - length):
				tmp = 1
				for runner in range(length):
					tmp *= the_grid[i+runner][j+runner]
				if d1_max < tmp:
					d1_max = tmp

			# Diagonal /
			# Skip first LENGTH rows and last LENGTH columns
			if (i >= length-1) and (j <= cols - length):
				tmp = 1
				for runner in range(length):
					tmp *= the_grid[i-runner][j+runner]
				if d2_max < tmp:
					d2_max = tmp

			# # Vertical |
			# if i <= rows-length:
			# 	tmp = 1
			# 	for runner in range(length):
			# 		tmp *= the_grid[i+runner][j]
			# 	if max_val < tmp:
			# 		max_val = tmp

	return hor_max, ver_max, d1_max, d2_max


# Problem #12: Highly divisible triangular number
def triangular_number_with_n_divisors(num):
	runner = 0
	i = 1
	tmp = 0

	while i < 10000000:
		runner += i
		i += 1

		tmp = find_dividers(runner)
		# print(runner, find_dividers(runner))
		if len(tmp) >= num:
			break

	return runner, len(tmp)

# Problem #13: Large sum
def big_nums():
	the_big_num =  [37107287533902102798797998220837590246510135740250, 46376937677490009712648124896970078050417018260538,
					74324986199524741059474233309513058123726617309629, 91942213363574161572522430563301811072406154908250,
					23067588207539346171171980310421047513778063246676, 89261670696623633820136378418383684178734361726757,
					28112879812849979408065481931592621691275889832738, 44274228917432520321923589422876796487670272189318,
					47451445736001306439091167216856844588711603153276, 70386486105843025439939619828917593665686757934951,
					62176457141856560629502157223196586755079324193331, 64906352462741904929101432445813822663347944758178,
					92575867718337217661963751590579239728245598838407, 58203565325359399008402633568948830189458628227828,
					80181199384826282014278194139940567587151170094390, 35398664372827112653829987240784473053190104293586,
					86515506006295864861532075273371959191420517255829, 71693888707715466499115593487603532921714970056938,
					54370070576826684624621495650076471787294438377604, 53282654108756828443191190634694037855217779295145,
					36123272525000296071075082563815656710885258350721, 45876576172410976447339110607218265236877223636045,
					17423706905851860660448207621209813287860733969412, 81142660418086830619328460811191061556940512689692,
					51934325451728388641918047049293215058642563049483, 62467221648435076201727918039944693004732956340691,
					15732444386908125794514089057706229429197107928209, 55037687525678773091862540744969844508330393682126,
					18336384825330154686196124348767681297534375946515, 80386287592878490201521685554828717201219257766954,
					78182833757993103614740356856449095527097864797581, 16726320100436897842553539920931837441497806860984,
					48403098129077791799088218795327364475675590848030, 87086987551392711854517078544161852424320693150332,
					59959406895756536782107074926966537676326235447210, 69793950679652694742597709739166693763042633987085,
					41052684708299085211399427365734116182760315001271, 65378607361501080857009149939512557028198746004375,
					35829035317434717326932123578154982629742552737307, 94953759765105305946966067683156574377167401875275,
					88902802571733229619176668713819931811048770190271, 25267680276078003013678680992525463401061632866526,
					36270218540497705585629946580636237993140746255962, 24074486908231174977792365466257246923322810917141,
					91430288197103288597806669760892938638285025333403, 34413065578016127815921815005561868836468420090470,
					23053081172816430487623791969842487255036638784583, 11487696932154902810424020138335124462181441773470,
					63783299490636259666498587618221225225512486764533, 67720186971698544312419572409913959008952310058822,
					95548255300263520781532296796249481641953868218774, 76085327132285723110424803456124867697064507995236,
					37774242535411291684276865538926205024910326572967, 23701913275725675285653248258265463092207058596522,
					29798860272258331913126375147341994889534765745501, 18495701454879288984856827726077713721403798879715,
					38298203783031473527721580348144513491373226651381, 34829543829199918180278916522431027392251122869539,
					40957953066405232632538044100059654939159879593635, 29746152185502371307642255121183693803580388584903,
					41698116222072977186158236678424689157993532961922, 62467957194401269043877107275048102390895523597457,
					23189706772547915061505504953922979530901129967519, 86188088225875314529584099251203829009407770775672,
					11306739708304724483816533873502340845647058077308, 82959174767140363198008187129011875491310547126581,
					97623331044818386269515456334926366572897563400500, 42846280183517070527831839425882145521227251250327,
					55121603546981200581762165212827652751691296897789, 32238195734329339946437501907836945765883352399886,
					75506164965184775180738168837861091527357929701337, 62177842752192623401942399639168044983993173312731,
					32924185707147349566916674687634660915035914677504, 99518671430235219628894890102423325116913619626622,
					73267460800591547471830798392868535206946944540724, 76841822524674417161514036427982273348055556214818,
					97142617910342598647204516893989422179826088076852, 87783646182799346313767754307809363333018982642090,
					10848802521674670883215120185883543223812876952786, 71329612474782464538636993009049310363619763878039,
					62184073572399794223406235393808339651327408011116, 66627891981488087797941876876144230030984490851411,
					60661826293682836764744779239180335110989069790714, 85786944089552990653640447425576083659976645795096,
					66024396409905389607120198219976047599490197230297, 64913982680032973156037120041377903785566085089252,
					16730939319872750275468906903707539413042652315011, 94809377245048795150954100921645863754710598436791,
					78639167021187492431995700641917969777599028300699, 15368713711936614952811305876380278410754449733078,
					40789923115535562561142322423255033685442488917353, 44889911501440648020369068063960672322193204149535,
					41503128880339536053299340368006977710650566631954, 81234880673210146739058568557934581403627822703280,
					82616570773948327592232845941706525094512325230608, 22918802058777319719839450180888072429661980811197,
					77158542502016545090413245809786882778948721859617, 72107838435069186155435662884062257473692284509516,
					20849603980134001723930671666823555245252804609722, 53503534226472524250874054075591789781264330331690]
	smaller_num = list(map((lambda x: int(str(x)[0:20])), the_big_num))
	return str(reduce((lambda x, y: x + y), smaller_num))[0:10]


# Problem #14: Longest Collatz sequence
def longest_chain(max_num):
	cache = [-1]*(max_num)
	length = sorted(list(map((lambda x: [collatz_length(x, cache), x]), range(1, max_num+1))))
	return length[-1]


# Problem 15: Lattice paths
def lattice_paths(x_size, y_size):
	# Record number of directions from a point to the finish.
	stored_points = {}

	# 'Lambda' expression for recursive search
	def traverse_lattice(x, y):
		# Get the surface of the remaining area to traverse
		the_surf = (x_size - x) * (y_size-y)
		if the_surf == 0:		# No surface -- only one path left
			return 1

		point_loc = f'{x_size - x}x{y_size-y}'
		if not point_loc in stored_points:
			tmp = 0
			tmp += traverse_lattice(x+1, y)
			tmp += traverse_lattice(x, y+1)
			stored_points[point_loc] = tmp		# Store traversed points

		return stored_points[point_loc]

	num_of_paths = traverse_lattice(0, 0)
	# print(stored_points)
	return num_of_paths


# Problem 16: Power digit sum
def power_digit_sum(num):
	return reduce((lambda x, y: int(x) + int(y)), list(str(2**num)))


# Problem 17: Number letter counts
def number_letter_counts(start, end):
	the_sum = 0
	for i in range(start, end+1):
		i_sum = 0

		digits = list(map((lambda x: int(x)), list(str(i))))
		print(i, digits, end=' :\t\t')

		# Count named numbers
		if (len(digits) > 1) and (digits[-2] == 1):		# Count teens
			i_sum += num_value(digits[-2]*10 + digits[-1])
			print(digits[-2]*10 + digits[-1], end='\t\t')
		elif digits[-1] > 0:							# Count single (last) digits
			i_sum += num_value(digits[-1])
			print(f'0{digits[-1]}', end='\t\t')

		if len(digits) > 1:
			if digits[-2] > 1:							# Count tens
				i_sum += num_value(digits[-2] * 10)
			if len(digits) > 2:
				if digits[-3] > 0:						# Count hundreds
					i_sum += num_value(digits[-3])
					i_sum += num_value(100)

				if len(digits) > 3:
					if digits[-4] > 0:					# Count thousands
						i_sum += num_value(digits[-4])
						i_sum += num_value(1000)

				# Add 'AND' like 'one hundred AND fifteen'
				if(digits[-1] > 0) or (digits[-2] > 0):
					i_sum += 3
					print('&', end='\t\t')

		print('|', i_sum)
		the_sum += i_sum

	return the_sum


# Problem 18/67: Maximum path sum I/II
def max_path_sum_one():
	# Load the triangle from the file
	the_triangle = []
	with open('../triangle_p67.txt', 'r') as triangle_file:
		# print(''.join(triangle_file))
		the_triangle = [list(map((lambda x: int(x)), row.strip().split(' '))) for row in triangle_file]
	# print(the_triangle)

	# Bottom-Up Breadth first
	while len(the_triangle) > 1:
		next_row = the_triangle.pop()
		j = 0
		while j < len(the_triangle[-1]):
			the_triangle[-1][j] += max(next_row[j], next_row[j+1])
			j += 1

	return the_triangle[0][0]


# Problem #20: Factorial digit sum
def sum_of_factorial_digits(factorial):
	the_factorial = [*str(reduce((lambda x, y: x*y), range(1, factorial)))]
	return reduce((lambda x, y: int(x)+int(y)), the_factorial)

#==========================================
# Problem #11: Largest product in a grid
# print(largest_product_in_a_grid(4))

# Problem #12: Highly divisible triangular number
# print(triangular_number_with_n_divisors(500))

# Problem #13: Large sum
# print(big_nums())

# Problem #14: Longest Collatz sequence
# print(longest_chain(1000000))

# Problem 15: Lattice paths
# print(lattice_paths(20, 20))

# Problem 16: Power digit sum
# print(power_digit_sum(1000))

# Problem 17: Number letter counts
#print(number_letter_counts(1, 1000))

# Problem 18: Maximum path sum I
# print(max_path_sum_one())

# Problem #19: Counting Sundays
# skip

# Problem #20: Factorial digit sum
print(sum_of_factorial_digits(100))


