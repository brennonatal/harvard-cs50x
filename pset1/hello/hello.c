#include <stdio.h>      // standard library
#include <cs50.h>       // cs50 library

int main(void)          // main function
{
    string name = get_string("What is your name?\n");       // getting user input

    printf("hello. %s\n", name);        // printing response
}