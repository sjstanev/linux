# netcat
start listening on local port
nc -nlvp 5000 -e /bin/bash

to create remote connection use
nc <ip-address> <port> 
nc 192.168.10.200 5000

to check app/service 

nc <ip_address> <port> -nv
