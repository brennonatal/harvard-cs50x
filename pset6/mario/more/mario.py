# importing get_int from cs50 library
from cs50 import get_int

n = 0
# forcing n to be between 1 and 8
while n < 1 or n > 8:
    # getting user input
    n = get_int("Height: ")

# adding 1 to n
n = n + 1
for j in range(n - 1, 0, -1):
    # printing stairs
    print(" " * (j-1) + "#" * (n - j) + "  " + "#" * (n - j))