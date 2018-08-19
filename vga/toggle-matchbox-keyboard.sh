#!/bin/bash
#This script toggle the virtual keyboard

PID=`pidof matchbox-keyboard`
if [ ! -e $PID ]; then
  killall matchbox-keyboard
else
 matchbox-keyboard&
fi