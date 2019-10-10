#!/bin/bash
# echo Hello World
# Install dependencies ############################################################

echo "Would you like to install on 3.4.69-rt85 kernel? (y/n)"
read foo
if [ "$foo" = "y" ];then
       echo "YES"
else
       echo "NO"
fi
