#include <stdio.h>
#include <cs50.h>
#include <string.h>
#include <math.h>

int main(void)
{
    int words = 1, letters = 0, sentences = 0;      // initializing words as 1 to count last word that isn't followed by a space
    string text = get_string("Text: ");             // getting text from user
    int len = strlen(text);                         // getting text length



    letters = len;

    for (int i = 0; i < len; i++)                   // iterating over text
    {
        if (text[i] == ' ')                         // counting words
        {
            words++;
            letters--;
        }
        else if (text[i] == '!' || text[i] == '.' || text[i] == '?')        // counting sentences
        {
            sentences++;
            letters--;
        }
        else if (text[i] == ',' || text[i] == '"' || text[i] == ':' || text[i] == '-' || text[i] == 39 || text[i] == ';')
        {
            // removing espacial characters from letters count
            letters--;

        }
    }

    float L = (float)letters / words * 100;               // L is the average number of letters per 100 words in the text
    float S = (float)sentences / words * 100;             // S is the average number of sentences per 100 words in the text

    float grade = round(0.0588 * L - 0.296 * S - 15.8);     // calculating grade

    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (grade > 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %.0f\n", grade);
    }

}