#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <ctype.h>

int hasDuplicates(string);

int main(int argc, string argv[])
{
    if (argc != 2)          // checking for only one argument
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    string key = argv[1];       // getting argument and assigning to key

    if (strlen(key) != 26)      // quit if key doesn't have exatly 26 characters
    {
        printf("Key must contain 26 characters.\n");
        return 1;
    }

    for (int i = 0; i < 26; i++)        // iterating over key to find invalid characters
    {
        if (isdigit(key[i]))            // quit if find a digit
        {
            printf("The key shouldn't have any digits.\n");
            return 1;
        }
        if (islower(key[i]))            // turn any lowercase character into uppercase
        {
            key[i] = toupper(key[i]);
        }

    }

    if (hasDuplicates(key))             // check for duplicate characters
    {
        printf("The shouldn't have duplicate characters.\n");
        return 1;
    }

    string plaintext = get_string("plaintext: ");       // getting message to encrypt from user input

    int length = strlen(plaintext);         // storing message length
    char ciphertext[length];                // initializing chypertext with the same length as our plaintext

    for (int i = 0; i < length; i++)        // iteraring over plain text to encrypt
    {
        if (islower(plaintext[i]))          // if the character is lowercase subtract 97 (ascii code) from it
        {
            int location = (int) plaintext[i] - 97;     // find location of character in our key
            ciphertext[i] = tolower(key[location]);
        }
        else if (isupper(plaintext[i]))     // if the character is uppercase subtract 65 (ascii code) from it
        {
            int location = (int) plaintext[i] - 65;     // find location of character in our key
            ciphertext[i] = key[location];
        }
        else
        {
            ciphertext[i] = plaintext[i];               // if is a especial character, just copy it as it is
        }

    }

    ciphertext[length] = '\0';                  // setting final of our cyphertext to print if correctly

    printf("ciphertext: %s\n", ciphertext);


    return 0;
}

int hasDuplicates(string key)
{

    for (int i = 0; i < 26; i++)             // iterating over key to search for duplicates
    {

        for (int j = i + 1; j < 26; j++)
        {
            if (key[i] == key[j] && key[i] != ' ')
                // if we find a character that we have already seen and it isn't a space
                // we have a duplicate character, so return 1
            {
                return 1;
            }
        }
    }

    return 0;

}