#!/bin/bash

#IPv4 forward
/usr/bin/socat TCP4-LISTEN:443,fork TCP4:1.1.1.1:80 &
/usr/bin/socat UDP4-LISTEN:443,fork UDP4:1.1.1.1:80 &

#IPv6 forward
/usr/bin/socat TCP4-LISTEN:443,fork TCP6:[2606:4700:4700::1111]:80 &
/usr/bin/socat UDP4-LISTEN:443,fork UDP6:[2606:4700:4700::1001]:80 &

wait
