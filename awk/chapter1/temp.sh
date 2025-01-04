#!/usr/bin/awk -f

# print the name and pay (rate times hours) for everyone who worked more than zero hours.
awk '$3 > 0 {print $1, $2*$3}' emp.data

echo

# print the names of those employees who did not work, type this command line:
awk '$3==0 {print $1}' emp.data
exit 0



awk '{printf("%s Name: %s price is: $%.2f \n", NR, $1, $2*$3)}' emp.data 

# The first specification, %-8s, prints a name as a string of characters 
# left-justified in a field 8 characters wide; the minus sign signals that the name is to be left-justified in its field.
# The second specification, %6.2f, prints the pay as a number with two digits after the decimal point, in a field 6 characters wide:
awk '{ printf("%-8s $%6.2f\n", $1, $2 * $3) }' emp.data 