# Linux-Courses
This repo holds linux courses: homework, exams, projects, exercises

## 1. Pattern Matching
Definition:
Pattern matching refers to checking if a sequence of characters matches a predefined pattern. These patterns can be simple or limited in capability compared to regular expressions.

Characteristics:
Simplicity: Often involves basic wildcard characters or fixed strings.
Limited Syntax: Typically uses simple constructs like * (match zero or more characters) or ? (match a single character).
Application-Specific: Commonly used in shell scripting, file globbing, or basic string comparisons.
Less Power: Cannot match more complex patterns like repetitions, groups, or alternations.
Example:
In a Bash script or file globbing:

bash
Copy code
ls *.txt
* matches any number of characters.
This will list all files ending in .txt.
Pattern matching is straightforward but lacks the flexibility and expressiveness of regular expressions.

2. Regular Expressions (Regex)
Definition:
Regular expressions are a formalized way to describe complex text patterns using a rich syntax of symbols and operators.

Characteristics:
Powerful Syntax: Can define very intricate patterns, including repetitions, alternations (|), groupings (()), and more.
Complexity: Requires understanding of a wide range of special characters (., +, *, [ ], ?, { }, etc.).
Universality: Used in many programming languages and tools (e.g., Python, Java, grep, sed, awk).
Versatile Applications: Used for advanced text processing tasks like validation, searching, replacing, and parsing.
Example:
In regular expressions:

regex
Copy code
\d{3}-\d{2}-\d{4}
This matches strings in the format of a U.S. Social Security Number (e.g., 123-45-6789).

In Bash using regex:

bash
Copy code
echo "hello123" | grep -E 'hello[0-9]+'
This matches any string that starts with hello followed by one or more digits.

Key Differences


The main difference boils down to complexity and power:

Pattern Matching: Simpler, with limited capabilities (e.g., wildcards like * and ? for file names).
Regular Expressions: Far more powerful and flexible, capable of defining intricate text patterns.
If you ever want more details, feel free to ask! 😊



![Screenshot from 2024-12-22 21-40-37](https://github.com/user-attachments/assets/38e75bf9-9648-4247-a42c-a3b074b32b94)


You said:
you typed  - limited Syntax: Typically uses simple constructs like * (match zero or more characters) or ? (match a single character).
can you give me all the symbols (constractions ) that I can use with pattern matching?
ChatGPT said:
ChatGPT
In pattern matching (e.g., file globbing in a shell), the available symbols or constructs are simpler compared to regular expressions. Here’s a list of the most common ones:

1. Wildcards
*
Matches zero or more characters in a filename.
Example:

*.txt matches file.txt, myfile.txt, or even .txt.
file* matches file, file1, file_name, etc.
?
Matches exactly one character.
Example:

file?.txt matches file1.txt or fileA.txt but not file12.txt.
2. Brackets for Character Sets
[abc]
Matches one character from the specified set.
Example:

file[123].txt matches file1.txt, file2.txt, or file3.txt.
[a-z]
Matches one character in the specified range.
Example:

file[a-c].txt matches filea.txt, fileb.txt, or filec.txt.
[!abc] or [^abc]
Matches one character NOT in the specified set.
Example:

file[!1-3].txt matches file4.txt but not file1.txt, file2.txt, or file3.txt.
3. Escaping Special Characters
\
Escapes special characters to match them literally.
Example:
file\*.txt matches the filename file*.txt (not file1.txt).
4. Alternation (Bash Extended Glob)
(Enabled with shopt -s extglob in Bash)

@(pattern1|pattern2)
Matches either of the patterns.
Example:

@(file1|file2).txt matches file1.txt or file2.txt.
!(pattern)
Matches everything except the pattern.
Example:

!(file1).txt matches any .txt file except file1.txt.
*(pattern)
Matches zero or more occurrences of the pattern.
Example:

*(file).txt matches file.txt, filefile.txt, etc.
+(pattern)
Matches one or more occurrences of the pattern.
Example:

+(file).txt matches file.txt or filefile.txt, but not .txt.
?(pattern)
Matches zero or one occurrence of the pattern.
Example:

?(file).txt matches .txt or file.txt.
5. Double Asterisks for Recursive Matches
(Enabled with shopt -s globstar in Bash)

**
Matches files and directories recursively.
Example:
**/*.txt matches all .txt files in the current directory and all subdirectories.
Summary Table:

![image](https://github.com/user-attachments/assets/295f6449-929a-481b-97c1-20e3dd35fd0f)
