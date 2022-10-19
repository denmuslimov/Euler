import sys
import math
from functools import reduce


def find_divider_sum(num):
    print(num)
    returner = 1
    check_untill = math.floor(math.sqrt(num))
    if check_untill*check_untill == num:
        returner += check_untill
        check_untill -= 1

    for div in range(2, check_untill):
        if num % div == 0:
            returner += div
            returner += num//div

    return returner


def factorial(num):
    return reduce((lambda x, y: x*y), range(1, num+1))


def get_prime_list(max_num):
    returner = [True]*max_num
    returner[0] = False
    returner[1] = False

    runner = 1
    while runner < max_num/2:
        runner += 1
        if returner[runner]:
            for i in range(2*runner, max_num, runner):
                returner[i] = False

    return returner




# Problem #21: Amicable numbers
def amic_num(num):
    runner = map( (lambda x: find_divider_sum(x)), list(range(1, num+1)))
    return list(runner)


# Problem #24: Lexicographic permutations
def permutation_with_index(nums, index):
    returner = ''
    runners = nums
    remainer = index-1
    n = len(nums)

    # Find the first digits that are not in a row
    for i in range(1, n+1):
        j = int(remainer / factorial(n-i))
        print("j: ", j, "\t\trunners: ", runners)
        remainer = remainer % factorial(n - i)
        returner += str(runners[j])
        runners.pop(j)
        print("returner: ", returner, "\t\tremainer: ", remainer)

        if remainer == 0:
            break

    # Add the rest
    returner += ''.join(map(str, runners))

    return returner


# Problem #25: 1000-digit Fibonacci number
def first_fibonachy_by_digit_count(digit_count):
    a = 1
    b = 1
    step = 2
    stop_cond = 10**(digit_count-1)

    while (b < stop_cond) and (step < 10000000000):
        a, b = b, a + b
        step += 1
    return step


# Problem #26: Reciprocal cycles
def reciprocal_cycles(num):
    returner = 0
    max_length = 0
    for runner in range(2, num+1):
        start_dividend = 1
        dividend = start_dividend * 10 % runner
        dividents = {}
        counter = 0
        while not dividend in dividents:
            counter += 1
            dividents[dividend] = counter
            dividend = dividend * 10 % runner

        if counter > max_length:
            max_length = counter
            returner = runner
    return returner

# Problem #27: Quadratic primes
def quad_primes(max_num):
    # N^2 + a*N + b = <prime number> for multiple consecutive N, starting with 0.
    # N == 0: b = <prime number>
    # N == 1: 1 + a + b = <prime number>
    #         Apart from 2, all prime numbers are odd --> a is even
    prime_numbers = get_prime_list(max_num**2)
    max_consec = { 'n': 0, 'a': 0, 'b':0 }

    start_a = -1*max_num
    end_a = max_num+1
    if max_num % 2 == 0:
        start_a = -1*max_num + 1
        end_a = max_num

    for a in range(start_a, end_a, 2):
        for b in range(max_num):
            if not prime_numbers[b]: continue
            a_odd = 0
            if b % 2 == 0: a_odd = -1

            for n in range(10000000):
                n += 1
                test_result = n**2 + n*(a+a_odd) + b
                if not prime_numbers[test_result]:
                    if n > max_consec['n']:
                        # print('\t\t\tResult', n)
                        max_consec['n'] = n
                        max_consec['a'] = (a+a_odd)
                        max_consec['b'] = b
                    break
    return max_consec, max_consec['a'] * max_consec['b']




#==========================================
# Problem #21: Amicable numbers
# print(amic_num(10))

# Problem #24: Lexicographic permutations
# print(permutation_with_index(list(range(10)), 1000000))

# Problem #25: 1000-digit Fibonacci number
# print(first_fibonachy_by_digit_count(1000))

# Problem #26: Reciprocal cycles
# print(reciprocal_cycles(1000))

# Problem #27: Quadratic primes
print(quad_primes(1000))

