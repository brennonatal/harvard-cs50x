#include <stdio.h>
#include <cs50.h>
#include <stdbool.h>

int countDigits(long);              // method to count digits
long getFirstDigits(int, long);     // method to get first digit
bool checkSum(long);                // method to check if the number is valid
void checkBank(int, int, long);     // method to check Amex, Visa or MasterCard

int main(void)
{
    long number;

    do
    {
        number = get_long("Number: ");      // getting valid number
    }
    while (number <= 0);

    int digits = countDigits(number);
    long firstDigits = getFirstDigits(digits, number);

    if (!checkSum(number))      // if the sum does not pass thge test, the number is invalid\n
    {
        printf("INVALID\n");
    }
    else
    {
        checkBank(firstDigits, digits, number);
    }

}

void checkBank(int firstDigits, int digits, long number)
{
    if (firstDigits / 10 == 4 && (digits == 16 || digits == 13))       // conditions fo visa
    {
        printf("VISA\n");
    }
    else if (firstDigits >= 51 && firstDigits <= 55 && digits == 16)        // conditions for mastercard
    {
        printf("MASTERCARD\n");
    }
    else if ((firstDigits == 34 || firstDigits == 37) && digits == 15)      // conditions for amex
    {
        printf("AMEX\n");
    }
    else
    {
        printf("INVALID\n");
    }

}

long getFirstDigits(int digits, long number)
{
    long first = number;
    while (first >= 100)    // divide number until it lasts only the 2 first
    {
        first = first / 10;
    }
    return first;
}

bool checkSum(long number)
{
    long firstSum = 0, secondSum = 0, total = 0;
    int adding = 0;

    while (number > 0)
    {
        secondSum += number % 10;               // getting numbers for second sum
        number /= 10;
        adding = ((number % 10) * 2);           // getting numbers for first sum
        if (adding > 9)
        {
            firstSum += adding % 10;
            firstSum += adding / 10;
        }
        else
        {
            firstSum += adding;
        }
        number /= 10;
    }

    total = firstSum + secondSum;               // calculating total

    if (total % 10 == 0)                         // checking if sum if valid
    {
        return true;
    }
    else
    {
        return false;
    }
}

int countDigits(long number)
{
    int n = 0;

    while (number > 0)
    {
        number /= 10;           // dividing number by 10
        n++;                    // adding 1 to counter
    }

    return n;
}