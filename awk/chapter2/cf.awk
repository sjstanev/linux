# cf: units conversion for temperature, length, weight

awk 'BEGIN {

  t = ARGV[1]  # first command-line argument

  printf("%s C = %.1f F;  %s F = %.1f C\n",

    t, t*9/5 + 32, t, (t-32)*5/9)

  printf("%s cm = %.1f in;  %s in = %.1f cm\n",

    t, t/2.54, t, t*2.54)

  printf("%s kg = %.1f lb;  %s lb = %.1f kg\n",

    t, 2.2*t, t, t/2.2)

}' $*

# The $* in the script is the shell notation for the arguments 
# that the program was called with; the shell expands it into 
# a list of strings that are passed to the programhe $* 
# in the script is the shell notation for the arguments 
# that the program was called with; the shell expands it into 
# a list of strings that are passed to the program