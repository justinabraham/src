#!/bin/bash
# echo Hello World
# Install dependencies ############################################################

kernel=$(uname -r)
expected=3.4.69-rt85

if [ "$kernel" = "$expected" ];then
       echo "Correct kernel loaded."
else
       echo "== FAILED ==. Reboot system and choose 3.4.69-rt85 kernel under Advanced options in the Grub menu."
fi
