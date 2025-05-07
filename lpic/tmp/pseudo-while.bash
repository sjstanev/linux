#!/usr/bin/bash
##
##  Author: Stanimir Stanev
##
##  Date: 3/17/2023
##
##  Purpose: learing bash scripting
##
##  Change Log:

clear

echo -n 'enter the key: '
read _KEY

while [[ $_KEY != '123' ]]
do
	echo -n 'almost there ... try again: '
	read _KEY
done

echo 'you got it'

