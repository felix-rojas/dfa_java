import re
import os

def parse_identifier(string):
    pattern = r'^[a-zA-Z$]|[_]+[a-zA-Z\d_$]+$'
    p = re.compile(pattern)
    match = p.match(string)
    if match:
        print(f"'{string}' is a VALID IDENTIFIER")
    else:
        print(f"'{string}' NOT a valid identifier")

def parse_kwd(string):
    pattern = r'(\bmain\b)|(\bvoid\b)|(\bint\b)|(\bprivate\b)|(\bpublic\b)'
    match = re.match(pattern, string)
    if match:
        print(f"'{string}' is a RESERVED KEYWORD")


valid_strings = ["a","$astrid", "$$aa", "a$A$a$_", "b$", "A$a", "$as1111", "$____$$$$", "$$$as$$", "$_", "$", "a_", "_a", "_9", "_$", "__","_"," a",]
invalid_ids = ["12","1_2","1$2","1 2"," "," _","_ _","_","1main","2mark","2_mark","2__mark","2_$"," a"]

for s in valid_strings:
    parse_identifier(s)

for s in invalid_ids:
    parse_identifier(s)

file_dir = os.path.dirname(os.path.abspath(__file__))
file_path = "\kwds.txt"

if os.path.exists(file_dir+file_path):
    with open(file_dir+file_path, "r") as file:
        java_keywords = [line.rstrip("\n") for line in file]
else:
    print(f"{file_path} not found")

# this will only print the five selected keywords
for keyword in java_keywords:
    parse_kwd(keyword)