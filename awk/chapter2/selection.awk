#!/usr/bin/awk -f

# AWK script to read a file and print the specified number of lines.
BEGIN {
  # Check if the required arguments are provided.
  if (ARGC != 3) {
    print "Usage: awk -f script.awk <filename> <number_of_lines>" > "/dev/stderr"
    exit 1
  }

  # Parse arguments.
  filename = ARGV[1]
  num_lines = ARGV[2]

  # Remove arguments so AWK processes only the file content.
  delete ARGV[1]
  delete ARGV[2]

  # Check if num_lines is a positive integer.
  if (num_lines !~ /^[0-9]+$/ || num_lines <= 0) {
    print "Error: <number_of_lines> must be a positive integer." > "/dev/stderr"
    exit 1
  }

  # Open the file for reading.
  if ((getline < filename) == -1) {
    print "Error: Cannot open file \"" filename "\"." > "/dev/stderr"
    exit 1
  }
  close(filename)
}

{
  # Print the current line.
  print $0

  # Increment line counter.
  line_count++

  # Exit once the desired number of lines is printed.
  if (line_count == num_lines) {
    exit
  }
}

END {
  if (line_count < num_lines) {
    print "Warning: File has fewer than " num_lines " lines." > "/dev/stderr"
  }
}
