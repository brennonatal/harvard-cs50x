import csv
import cs50
from sys import argv, exit

# quit if the number of command-line arguments provided are incorrect
if len(argv) != 2:
    print('Usage: python import.py data.csv')
    exit(1)

# opening already created students data base
db = cs50.SQL('sqlite:///students.db')

with open(argv[1]) as characters:
    reader = csv.DictReader(characters)

    for row in reader:
        full_name = row['name'].split()
        # checking for lenght of name
        if (len(full_name) == 3):
            db.execute("INSERT INTO students (first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?)",
                       full_name[0], full_name[1], full_name[2], row['house'], row['birth'])
        else:
            db.execute("INSERT INTO students (first, middle, last, house, birth) VALUES(?, NULL, ?, ?, ?)",
                       full_name[0], full_name[1], row['house'], row['birth'])
