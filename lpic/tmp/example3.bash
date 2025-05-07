#!/usr/bin/env bash

# The primary difference between test and [ is that [ requires its last argument to be ]. 
# The result is that it looks like a pair of square brackets surrounding the condition:

[ -e /etc/passwd ] && echo 'Password file exists!'
