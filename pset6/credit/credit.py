from cs50 import get_int


def checkSum(number):   # function to check sum of digits
    firstSum = 0
    secondSum = 0
    total = 0
    adding = 0

    while number > 0:  # looking at every digit individualy
        secondSum += number % 10
        number /= 10
        adding = ((number % 10) * 2)
        if adding > 9:
            firstSum += adding % 10
            firstSum += adding / 10
        else:
            firstSum += adding

        number /= 10

    total = firstSum + secondSum

    return total % 10 == 0


number = get_int("Number: ")

n_digits = len(str(number))
first_two_digits = str(number)[0] + str(number)[1]
first_two_digits = int(first_two_digits)

if checkSum(number):    # if the sum does not pass the test, the number is invalid
    print("INVALID\n")
else:
    if int(first_two_digits / 10) == 4 and (n_digits == 16 or n_digits == 13):   # conditions to be VISA
        print("VISA\n")
    elif first_two_digits >= 51 and first_two_digits <= 55 and n_digits == 16:  # conditions to be MASTERCARD
        print("MASTERCARD\n")
    elif (first_two_digits == 34 or first_two_digits == 37) and n_digits == 15:  # conditions to be AMEX
        print("AMEX\n")
    else:
        print("INVALID\n")
