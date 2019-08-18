#!/bin/sh
do_mzp354hv05tr_txt() {
# now create txt file
cat > /boot/mzp351hv1tr.txt <<EOF
[pi4]
dtoverlay=ads7846,penirq=27,swapxy=1,xmin=150,xmax=3900,ymin=150,ymax=3900
display_rotate=0
gpio=18-19=op,dh,pd
dtoverlay=gpio-fan,gpiopin=19,temp=55000
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

do_mzdpi3_dtb() {
# now create dts file
cat <<\EOF > /boot/overlays/mzdpi3.dts && 
/dts-v1/;

/ {
	compatible = "brcm,bcm2708";

	fragment@0 {
		target = <0xdeadbeef>;

		__overlay__ {
			pinctrl-names = "default";
			pinctrl-0 = <0x1>;
		};
	};

	fragment@1 {
		target = <0xdeadbeef>;

		__overlay__ {

			dpi18_pins {
				brcm,pins = <0x0 0x1 0x2 0x3 0x4 0x5 0x6 0xc 0xd 0xe 0xf 0x10 0x11 0x14 0x15 0x16 0x17 0x18>;
				brcm,function = <0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6 0x6>;
				brcm,pull = <0x1>;
				linux,phandle = <0x1>;
				phandle = <0x1>;
			};
		};
	};

	__symbols__ {
		dpi18_pins = "/fragment@1/__overlay__/dpi18_pins";
	};

	__fixups__ {
		leds = "/fragment@0:target:0";
		gpio = "/fragment@1:target:0";
	};

	__local_fixups__ {
		fixup = "/fragment@0/__overlay__:pinctrl-0:0";
	};
};
EOF
dtc -W no-dmas_property -W no-unit_address_vs_reg -W no-unique_unit_address -W no-gpios_property -W no-avoid_unnecessary_addr_size -W no-clocks_property -I dts -O dtb -o /boot/overlays/mzdpi3.dtbo /boot/overlays/mzdpi3.dts
}

do_create_conf() {
if [ -f "/etc/X11/xorg.conf.d/99-calibration.conf" ];then
	return
fi

mkdir /etc/X11/xorg.conf.d
cat <<EOF > /etc/X11/xorg.conf.d/99-calibration.conf 
Section "InputClass"
	Identifier	"calibration"
	MatchProduct	"ADS7846 Touchscreen"
	Option	"Calibration"	"195 3895 240 3813"
	Option	"SwapAxes"	"0"
EndSection

EOF

}

apt-get install libfakekey0
apt-get install -y xserver-xorg-input-evdev
apt-get install -y xinput-calibrator

if [ -f "/usr/share/X11/xorg.conf.d/40-libinput.conf" ];then
	mv /usr/share/X11/xorg.conf.d/40-libinput.conf /usr/share/X11/xorg.conf.d/40-libinput.bak
fi

apt-get install -y matchbox-keyboard

do_create_conf
do_mzdpi3_dtb

../common/bcm2708-rpi-b-plus.sh
../common/bcm2708-rpi-cm.sh
../common/bcm2708-rpi-zero.sh
../common/bcm2708-rpi-zero-w.sh
../common/bcm2709-rpi-2-b.sh
../common/bcm2710-rpi-3-b.sh
../common/bcm2710-rpi-3-b-plus.sh
../common/bcm2710-rpi-cm3.sh
../common/bcm2711-rpi-4-b.sh
do_mzp354hv05tr_txt

cp /boot/config.txt /boot/tmp.txt

sed  -i "/include mzp/d" /boot/tmp.txt
echo "[all]" >> /boot/tmp.txt
echo "include mzp354hv05tr.txt" >> /boot/tmp.txt

cp /boot/tmp.txt /boot/config.txt

