#!/bin/bash
# 
DATE = 
echo start with var $DATE
echo ${DATE:-todayshow}
# today
echo $DATE

echo ${DATE:=todayset}
# today
echo $DATE
# today

TIME=
# echo ${TIME:?variable not set by the script}
echo $TIME

TIME=$(date +%d-%m-%y)
echo the day is ${TIME:0:2}
