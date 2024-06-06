import re
import os
from time import process_time_ns


def read_file(file_name):
    file_dir = os.path.dirname(os.path.abspath(__name__))
    path_to_file = os.path.join(file_dir, file_name)

    if os.path.exists(path_to_file):
        with open(path_to_file, "r") as file:
            return [line.rstrip("\n") for line in file]
    else:
        print(f"{file_name} not found")


def lps(pattern):
    length = 0
    _lps = [0] * len(pattern)
    i = 1
    while i < len(pattern):
        if pattern[i] == pattern[length]:
            length += 1
            _lps[i] = length
            i += 1
        else:
            if length != 0:
                length = _lps[length - 1]
            else:
                _lps[i] = 0
                i += 1
    return _lps


def kmp(pattern, text):
    m = len(pattern)
    n = len(text)
    lps_arr = lps(pattern)
    i = 0
    j = 0
    while i < n:
        if pattern[j] == text[i]:
            i += 1
            j += 1
            # print(f"Match found at pos: {i} of string at {j} index")
        if j == m:
            # print(f"\nFull pattern found from {i - j} to {i} \n")
            j = lps_arr[j - 1]
        elif i < n and pattern[j] != text[i]:
            if j != 0:
                j = lps_arr[j - 1]
            else:
                i += 1


def parse_identifier(string):
    pattern = r'^[a-zA-Z$]|[_]+[a-zA-Z\d_$]+$'
    p = re.compile(pattern)
    match = p.match(string)
    if match:
        print(f"'{string}' is a VALID IDENTIFIER")
    else:
        print(f"'{string}' NOT a valid identifier")


def parse_kwd(string):
    pattern = r'main|void|int|private|public'
    match = re.match(pattern, string)
    if match:
        print(f"'{string}' is a RESERVED KEYWORD")


valid_strings = ["a", "$astrid", "$$aa", "a$A$a$_", "b$", "A$a",
                 "$as1111", "$____$$$$", "$$$as$$", "$_", "$", "a_",
                 "_a", "_9", "_$", "__", "_", " a", ]
invalid_ids = ["12", "1_2", "1$2", "1 2", " ", " _", "_ _", "_",
               "1main", "2mark", "2_mark", "2__mark", "2_$", " a"]

for s in valid_strings:
    parse_identifier(s)

for s in invalid_ids:
    parse_identifier(s)


java_keywords = read_file("kwds.txt")
java_program = read_file("java_program.txt")
java_string = "".join(java_program)

# Time test KMP vs regex

print("Time test KMP vs regex")

start = process_time_ns()
for keyword in java_string:
    parse_kwd(keyword)
stop = process_time_ns()

start1 = process_time_ns()
for keyword in ["main", "void", "int", "private", "public"]:
    kmp(keyword, java_string)
stop1 = process_time_ns()
print(f"Executed KMP in {(stop1 - start1)//1000} ms VS Regex in {(stop - start)//1000} ms")
