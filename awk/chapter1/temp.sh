#!/bin/bash

# print the name and pay (rate times hours) for everyone who worked more than zero hours.
awk '$3 > 0 {print $1, $2*$3}' emp.data

echo

# print the names of those employees who did not work, type this command line:
awk '$3==0 {print $1}' emp.data
exit 0
