#!/bin/sh

if [ "$1" = "mount" ];
then
  # This already assumes that dislocker is already installed and configured correctly.
  # It also assumes that the bitlocker disk are mounted to /dev/sdc5 & /dev/sdc7

  mkdir /media/blmaster
  mkdir /media/mountmaster
  sudo umount /media/blmaster
  sudo dislocker -V /dev/sdc5 -u -- /media/blmaster
  cd /media/blmaster
  sudo mount -o loop dislocker-file /media/mountmaster

  mkdir /media/blblue
  mkdir /media/mountblue
  sudo umount /media/blblue
  sudo dislocker -V /dev/sdc7 -u -- /media/blblue
  cd /media/blblue
  sudo mount -o loop dislocker-file /media/mountblue
else
  sudo umount /media/mountmaster
  sudo umount /media/mountblue
  sudo umount /media/blmaster
  sudo umount /media/blblue
fi
