#!/usr/bin/awk -f

# You can put several statements on a single line if you separate them by semicolons. Notice that print "" prints a blank line,
# quite different from just plain print, which prints the current input line. 

BEGIN { print "NAME RATE HOURS"; print "" }
{ print }
$3 > 15 { emp++ }
{ names = names $1 " " }
END     { print "\n"; print emp, "employees worked more than 15 hours" ; print names}
