#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int n;      // number of pyramid height
    char hash = '#';

    do
    {
        n = get_int("Height: ");        // getting height from user input
    }
    while (n < 1 || n > 8);             // forcing n to be between 1 and 8

    char space = ' ';                   // space to align pyramid blocks
    int iSpace = n - 1;                 // spaces counter
    int iChar = 1;                      // char counter

    for (int j = 1; j <= n; j++)        // number of rows
    {

        for (int i = 0; i < iSpace; i++)        // number of spaces needed to align
        {
            printf("%c", space);
        }

        for (int i = 1; i <= iChar; i++)        // number of hashs per row
        {
            printf("%c", hash);
        }

        printf("  ");                           // space between

        for (int i = 1; i <= iChar; i++)        // number of hashs per row
        {
            printf("%c", hash);
        }


        iSpace--;                               // decreasing spaces
        iChar++;                                // increasing hashs
        printf("\n");
    }

}
