#!/bin/bash/awk -f
{ printf("%6.2f  %s\n", $2 * $3, $0) }
