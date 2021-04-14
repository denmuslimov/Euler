import sys
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

#==========================================
# Problem #11: Largest product in a grid
# print(largest_product_in_a_grid(4))

# Problem #12: Highly divisible triangular number
# print(triangular_number_with_n_divisors(500))

# skip
# skip

# Problem 15: Lattice paths
# print(lattice_paths(20, 20))

# Problem 16: Power digit sum
# print(power_digit_sum(1000))

# Problem 17: Number letter counts
#print(number_letter_counts(1, 1000))

# Problem 18: Maximum path sum I
print(max_path_sum_one())


