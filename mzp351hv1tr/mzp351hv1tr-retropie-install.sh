#!/bin/sh
do_mzp351hv1tr_txt() {
# now create txt file
cat > /boot/mzp351hv1tr.txt <<EOF
disable_overscan=1
display_rotate=0
gpio=18-19=op,dh,pd
gpio=0-8=a2
gpio=12-17=a2
gpio=20-24=a2
gpio=9-11=a0
framebuffer_width=480
framebuffer_height=320
enable_dpi_lcd=1
display_default_lcd=1
dpi_group=2
dpi_mode=87

dpi_output_format=0x07f003
hdmi_timings=480 0 228 18 28 320 0 2 2 28 0 0 0 60 0 32000000 1

[pi4]
dtoverlay=vc4-fkms-v3d
max_framebuffers=2
dpi_output_format=0x07f203
hdmi_timings=480 0 2 8 8 320 0 2 2 4 0 0 0 120 0 12000000 4

EOF
}
do_mzp351hv1tr_txt

cp /boot/config.txt /boot/tmp.txt

sed  -i "/include mzp/d" /boot/tmp.txt
echo "[all]" >> /boot/tmp.txt
echo "include mzp351hv1tr.txt" >> /boot/tmp.txt

cp /boot/tmp.txt /boot/config.txt

FILE=/etc/rc.local
if [ -f "$FILE" ];then
cp /etc/rc.local /boot/tmp.txt
sed  -i "/exit 0/d" /boot/tmp.txt
echo "sudo python /home/pi/MZDPI/common/led-pwm.py &" >> /boot/tmp.txt
echo "sudo python /home/pi/MZDPI/common/fan-pwm.py &" >> /boot/tmp.txt
echo "exit 0" >> /boot/tmp.txt
cp /boot/tmp.txt /etc/rc.local
rm /boot/tmp.txt
fi