import cs50
from sys import argv, exit

# quit if the number of command-line arguments provided are incorrect
if len(argv) != 2:
    print('Usage: python roster.py <house')
    exit(1)

# opening already created students data base
db = cs50.SQL('sqlite:///students.db')

students = db.execute("SELECT * FROM students WHERE house LIKE ? ORDER BY last", argv[1])

for s in students:
    if (isinstance(s['middle'], str)):
        print(f"{s['first']} {s['middle']} {s['last']}, born {s['birth']}")
    else:
        print(f"{s['first']} {s['last']}, born {s['birth']}")
