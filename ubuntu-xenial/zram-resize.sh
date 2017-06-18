#!/bin/sh

# cat /etc/init/zram-config.conf
# /sbin/zram-config-start

sudo swapoff /dev/zram0
sudo zramctl --reset /dev/zram0
sudo zramctl --find --size 2G
sudo mkswap /dev/zram0
sudo swapon -p 5 /dev/zram0
