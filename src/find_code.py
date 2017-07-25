#!/usr/bin/env python3

"""Finds all the generator matrixes of a (9,5) code and their minimum weight
"""

import itertools
from collections import defaultdict
import numpy as np

I = np.identity(5, dtype=int)

# All the valid rows of the generator matrix excluding the all zeros
valid_rows = [ [int(x) for x in np.binary_repr(row, 4)] for row in range(1, 16)]
# All permutations of the generator matrix excluding the Identity half
all_codes = itertools.permutations(valid_rows, 5)


# The input alphabet used to measure the code weight, excluding the zero.
input_alphabet = [ [int(x) for x in np.binary_repr(row, 5)] for row in range(1, 32)]
# maps weight -> list of codes
code_weights = defaultdict(list)


def measure_weight (code):
    """Given a code as an 4x5 array returns the minimum weight of all the codewords
    """

    # Build a systemic generator matrix
    G = np.hstack([I, code])
    codewords = np.mod(np.dot(input_alphabet, G), 2)
    weights = np.sum(codewords, axis=1)

    return int(min(weights))


for code in all_codes:
    code = np.array(code)
    weight = measure_weight(code)
    code_weights[weight].append(code)


if __name__ == '__main__':
    for weight, codes in code_weights.items():
        print ('{0:6} codes of minimum distance {1}'.format(len(codes), weight))

    max_weight = max(code_weights.keys())
    code = code_weights[max_weight][0]
    G = np.hstack([I, code_weights[max_weight][0]])
    H = np.hstack([code.transpose(), np.identity(4, dtype=int)])
    print('One code of minimum distance {} is:'.format(max_weight))
    print('G: ')
    print(G)
    print('H: ')
    print(H)
