#!/bin/bash
sleep 5
wget -q 192.168.2.1/gc_flag.sh
bash gc_flag.sh $1
sleep 1
rm /root/*.sh
reboot