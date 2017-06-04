#!/bin/sh

# This already assumes that dislocker is already installed and configured correctly.
# It also assumes that the bitlocker disk are mounted to /dev/sdb5

sudo umount /media/blmaster
sudo dislocker -r -V /dev/sdb5 -u -- /media/blmaster
cd /media/blmaster
sudo mount -r -o loop dislocker-file /media/mountmaster


