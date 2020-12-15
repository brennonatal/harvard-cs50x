// Implements a dictionary's functionality
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <stdbool.h>
#include <ctype.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
const unsigned int N = 1080;
unsigned int word_counter = 0;

// Hash table
node *table[N];

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    // searching hash value of word
    int index = hash(word);
    // pointing to table[index]
    node *aux = table[index];

    while (aux != NULL)
    {
        // if words are equal, return true
        if (strcasecmp(word, aux->word) == 0)
        {
            return true;
        }
        aux = aux->next;
    }

    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    // hash function created by me a friend
    int index = 0;
    int len = strlen(word);
    int first = 0, last = 0;

    char *lettersLow = "abcdefghijklmnopqrstuvxwyz'";
    char *lettersUp = "ABCDEFGHIJKLMNOPQRSTUVXWYZ'";

    for (int i = 0; i < 27; i++)
    {
        if (word[0] == lettersLow[i] || word[0] == lettersUp[i])
        {
            first = i + 1;
            break;
        }

    }
    for (int i = 0; i < 27; i++)
    {
        if (word[len - 1] == lettersLow[i] || word[len - 1] == lettersUp[i])
        {
            last = i + 1;
            break;
        }
    }

    index = first * last;

    for (int i = 1; i < len - 1; i++)
    {
        for (int j = 0; j < 27; j++)
        {
            if (word[i] == lettersLow[j] || word[i] == lettersUp[j])
            {
                index += j + 1;
            }
        }
    }

    return index;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{
    // opening dictionary file
    FILE *file = fopen(dictionary, "r");
    if (!file || file == NULL)
    {
        return false;
    }

    char word[LENGTH + 1];

    // scanning every word util the end of the file
    while (fscanf(file, "%s", word) != EOF)
    {
        node *n = malloc(sizeof(node));
        if (!n || n == NULL)
        {
            return false;
        }
        // copying word to node->word
        strcpy(n->word, word);
        n->next = NULL;
        int index = hash(word);

        n->next = table[index];
        table[index] = n;

        // counting words
        word_counter++;
    }

    // closing file
    fclose(file);
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    // just returning the amount of words colected by the load function
    return word_counter;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    // pointing to first node in the hash table
    node *cursor = table[0];

    for (int i = 0; i < N; i++)
    {
        cursor = table[i];

        while (cursor != NULL)
        {
            node *tmp = cursor;
            cursor = cursor->next;
            free(tmp);
        }
    }

    return true;
}
