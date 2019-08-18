#!/bin/sh
do_mzp354hv05tr_txt() {
# now create txt file
cat > /boot/mzp354hv05tr.txt <<EOF
[pi4]
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

dtoverlay=vc4-fkms-v3d
max_framebuffers=2
dpi_output_format=0x07f203
hdmi_timings=480 0 2 8 8 320 0 2 2 4 0 0 0 120 0 12000000 4

EOF
}
do_mzp354hv05tr_txt

cp /boot/config.txt /boot/tmp.txt

sed  -i "/include mzp/d" /boot/tmp.txt
echo "[all]" >> /boot/tmp.txt
echo "include mzp354hv05tr.txt" >> /boot/tmp.txt

cp /boot/tmp.txt /boot/config.txt

