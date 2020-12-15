from sys import argv, exit
import csv

if len(argv) != 3:
    print("Usage: python dna.py data.csv sequence.txt")
    exit(1)

people_data = []


def getSequences(file):  # getting sequences to search on database
    with open(file, newline='') as database:    # opening database
        reader = csv.DictReader(database)
        for row in reader:
            sequences = list(row)
            person_data = []
            for i in range(len(row)):
                person_data.append(row[list(row)[i]])   # getting people data
            people_data.append(person_data)  # putting all data inside a matrix
    return sequences[1:len(sequences)]  # returning STRs to be used


def getDNA(file):
    with open(file, 'r') as dna:    # openning dna file
        reader = csv.reader(dna)
        for row in reader:
            return row[0]   # returning dna sequence


STRs = getSequences(argv[1])
dnaSequence = getDNA(argv[2])

str_matching = {"name": "No match"}  # creating dictonary for the dna we are looking for

# search for each str inside sequence
for s in STRs:
    highest_sequence = 0
    found = 0   # number of STRs found in sequence
    i = 0
    # iterating over sequence
    while i < len(dnaSequence):
        # getting sequence with the same size as the str
        if dnaSequence[i: i + len(s)] == s:  # if the sequence is equal to str
            found += 1
            i += len(s)  # check next sequence right after this one
        elif found >= highest_sequence:
            highest_sequence = found
            str_matching[s] = highest_sequence
            found = 0
            i += 1
        else:
            found = 0
            i += 1
match = len(STRs)   # number of matches needed
# seaching for matching in people_data
for p in people_data:
    for i in range(len(STRs)):
        if str_matching[STRs[i]] == int(p[i+1]):
            match -= 1
            if match == 0:
                print(p[0])
                exit(0)
    match = len(STRs)
print(str_matching['name'])
exit(0)