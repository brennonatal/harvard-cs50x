from cs50 import get_string

# getting sentence from user input
text = get_string('Text: ')

# using split() to count words in string
words = len(text.split())
# counting occurrencies of '.', '?' and '!' for number of sentences
sentences = text.count('!') + text.count('.') + text.count('?')
# counting all characters
letters = 0
for word in text.split():
    for c in word:
        if c >= 'A' and c <= 'z':
            letters += 1

L = letters / words * 100
S = sentences / words * 100

grade = round(0.0588 * L - 0.296 * S - 15.8)

if grade < 1:
    print('Before Grade 1\n')
elif grade > 16:
    print('Grade 16+\n')
else:
    print('Grade', grade)
