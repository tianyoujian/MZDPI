#!/bin/sh

cp /boot/config.txt /boot/tmp.txt

sed  -i "/include mzp354hv05tr/d" /boot/tmp.txt

cp /boot/tmp.txt /boot/config.txt
