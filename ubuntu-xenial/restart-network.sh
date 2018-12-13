#!/bin/bash
while true; do
x=`ping -c1 8.8.8.8 2>&1 | grep -E '100% packet loss|Network is unreachable'`
if [ ! "$x" = "" ]; then
        echo $(date) "It's down!! Attempting to restart."
        sudo service network-manager restart
fi

sleep 30
done
