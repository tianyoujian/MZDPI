#!/bin/sh

cp /boot/config.txt /boot/tmp.txt

sed  -i "/include mzp351hv1tr/d" /boot/tmp.txt

cp /boot/tmp.txt /boot/config.txt
