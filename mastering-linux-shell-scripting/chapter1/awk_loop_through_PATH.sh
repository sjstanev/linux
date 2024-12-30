#!/bin/bash

echo $PATH | awk 'BEGIN {FS = ":"; OFS = "\n"}; {for (i=1; i<=NF; ++i) {print $i}}; END {print "total: " NF}'
exit 0