#!/usr/bin/bash
##
##  Author: Stanimir Stanev
##
##  Date: 3/17/2023
##
##  Purpose: learing bash scripting
##
##  Change Log:

for _IPS in `dig google.com | grep ^google.com | awk '{ print $5 }'`; do ping -c 5 $_IPS; done