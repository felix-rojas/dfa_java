import re
import os
from time import process_time_ns
from regex_test import kmp, lps

def read_file(file_name):
    file_dir = os.path.dirname(os.path.abspath(__name__))
    path_to_file = os.path.join(file_dir, file_name)

    if os.path.exists(path_to_file):
        with open(path_to_file, "r") as file:
            return [line.rstrip("\n") for line in file]
    else:
        print(f"{file_name} not found")

def parse_kwd_test(string, pattern):
    re.match(pattern, string)
    return re.match(pattern, string)

java_keywords = read_file("kwds.txt")
java_program = read_file("java_program.txt")
java_string = "".join(java_program)

# Time test KMP vs regex

print("Time tests KMP vs regex")

five_kwds = ["public", "private", "main", "int", "void"]
small_pattern = fr"{'|'.join(five_kwds)}"
large_pattern = fr"{'|'.join(java_keywords)}"

start = process_time_ns()
for keyword in java_string:
    parse_kwd_test(keyword, small_pattern)
stop = process_time_ns()

start1 = process_time_ns()
for keyword in five_kwds:
    kmp(keyword, java_string)
stop1 = process_time_ns()
print(f"For {len(five_kwds)} keywords")
print(f"Executed KMP in {(stop1 - start1) // 1000} ms "
      f"VS Regex in {(stop - start) // 1000} ms")

start2 = process_time_ns()
for keyword in java_string:
    parse_kwd_test(keyword, large_pattern)
stop2 = process_time_ns()

start3 = process_time_ns()
for keyword in java_keywords:
    kmp(keyword, java_string)
stop3 = process_time_ns()

print(f"For {len(java_keywords)} keywords")
print(f"Executed KMP in {(stop3 - start3) // 1000} ms "
      f"VS Regex in {(stop2 - start2) // 1000} ms")
