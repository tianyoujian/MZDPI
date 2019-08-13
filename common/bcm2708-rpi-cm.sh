#!/bin/sh
# now create txt file
do_cm_dtb() {
# now create dts file
cat > /boot/bcm2708-rpi-cm.dts <<EOF
/dts-v1/;

/memreserve/	0x0000000000000000 0x0000000000001000;
/ {
	compatible = "brcm,bcm2835";
	model = "Raspberry Pi Compute Module";
	interrupt-parent = < 0x01 >;
	#address-cells = < 0x01 >;
	#size-cells = < 0x01 >;

	aliases {
		serial0 = "/soc/serial@7e201000";
		serial1 = "/soc/serial@7e215040";
		audio = "/soc/audio";
		aux = "/soc/aux@7e215000";
		sound = "/soc/sound";
		soc = "/soc";
		dma = "/soc/dma@7e007000";
		intc = "/soc/interrupt-controller@7e00b200";
		watchdog = "/soc/watchdog@7e100000";
		random = "/soc/rng@7e104000";
		mailbox = "/soc/mailbox@7e00b880";
		gpio = "/soc/gpio@7e200000";
		uart0 = "/soc/serial@7e201000";
		sdhost = "/soc/mmc@7e202000";
		mmc0 = "/soc/mmc@7e202000";
		i2s = "/soc/i2s@7e203000";
		spi0 = "/soc/spi@7e204000";
		i2c0 = "/soc/i2c@7e205000";
		uart1 = "/soc/serial@7e215040";
		spi1 = "/soc/spi@7e215080";
		spi2 = "/soc/spi@7e2150c0";
		mmc = "/soc/mmc@7e300000";
		mmc1 = "/soc/mmc@7e300000";
		i2c1 = "/soc/i2c@7e804000";
		i2c2 = "/soc/i2c@7e805000";
		usb = "/soc/usb@7e980000";
		leds = "/leds";
		fb = "/soc/fb";
		thermal = "/soc/thermal@7e212000";
		axiperf = "/soc/axiperf";
	};

	chosen {
		bootargs = "coherent_pool=1M";
	};

	thermal-zones {

		cpu-thermal {
			polling-delay-passive = < 0x00 >;
			polling-delay = < 0x3e8 >;
			thermal-sensors = < 0x02 >;
			coefficients = < 0xfffffde6 0x635d8 >;
			phandle = < 0x25 >;

			cooling-maps {
			};
		};
	};

	soc {
		compatible = "simple-bus";
		#address-cells = < 0x01 >;
		#size-cells = < 0x01 >;
		ranges = < 0x7e000000 0x20000000 0x2000000 >;
		dma-ranges = < 0x40000000 0x00 0x20000000 >;
		phandle = < 0x26 >;

		txp@7e004000 {
			compatible = "brcm,bcm2835-txp";
			reg = < 0x7e004000 0x20 >;
			interrupts = < 0x01 0x0b >;
			status = "disabled";
			phandle = < 0x27 >;
		};

		dma@7e007000 {
			compatible = "brcm,bcm2835-dma";
			reg = < 0x7e007000 0xf00 >;
			interrupts = < 0x01 0x10 0x01 0x11 0x01 0x12 0x01 0x13 0x01 0x14 0x01 0x15 0x01 0x16 0x01 0x17 0x01 0x18 0x01 0x19 0x01 0x1a 0x01 0x1b 0x01 0x1b 0x01 0x1b 0x01 0x1b 0x01 0x1c >;
			interrupt-names = "dma0\0dma1\0dma2\0dma3\0dma4\0dma5\0dma6\0dma7\0dma8\0dma9\0dma10\0dma11\0dma12\0dma13\0dma14\0dma-shared-all";
			#dma-cells = < 0x01 >;
			brcm,dma-channel-mask = < 0x7f35 >;
			phandle = < 0x08 >;
		};

		watchdog@7e100000 {
			compatible = "brcm,bcm2835-pm\0brcm,bcm2835-pm-wdt";
			#power-domain-cells = < 0x01 >;
			#reset-cells = < 0x01 >;
			reg = < 0x7e100000 0x114 0x7e00a000 0x24 >;
			clocks = < 0x03 0x15 0x03 0x1d 0x03 0x17 0x03 0x16 >;
			clock-names = "v3d\0peri_image\0h264\0isp";
			system-power-controller;
			phandle = < 0x1e >;
		};

		cprman@7e101000 {
			compatible = "brcm,bcm2835-cprman";
			#clock-cells = < 0x01 >;
			reg = < 0x7e101000 0x2000 >;
			clocks = < 0x04 0x05 0x00 0x05 0x01 0x05 0x02 0x06 0x00 0x06 0x01 0x06 0x02 >;
			firmware = < 0x07 >;
			phandle = < 0x03 >;
		};

		rng@7e104000 {
			compatible = "brcm,bcm2835-rng";
			reg = < 0x7e104000 0x10 >;
			interrupts = < 0x02 0x1d >;
			phandle = < 0x1f >;
		};

		mailbox@7e00b880 {
			compatible = "brcm,bcm2835-mbox";
			reg = < 0x7e00b880 0x40 >;
			interrupts = < 0x00 0x01 >;
			#mbox-cells = < 0x00 >;
			phandle = < 0x15 >;
		};

		gpio@7e200000 {
			compatible = "brcm,bcm2835-gpio";
			reg = < 0x7e200000 0xb4 >;
			interrupts = < 0x02 0x11 0x02 0x12 >;
			gpio-controller;
			#gpio-cells = < 0x02 >;
			interrupt-controller;
			#interrupt-cells = < 0x02 >;
			phandle = < 0x0d >;

			dpi_gpio0 {
				brcm,pins = < 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x15 0x16 0x17 0x18 0x19 0x1a 0x1b >;
				brcm,function = < 0x06 >;
				phandle = < 0x28 >;
			};

			emmc_gpio22 {
				brcm,pins = < 0x16 0x17 0x18 0x19 0x1a 0x1b >;
				brcm,function = < 0x07 >;
				phandle = < 0x29 >;
			};

			emmc_gpio34 {
				brcm,pins = < 0x22 0x23 0x24 0x25 0x26 0x27 >;
				brcm,function = < 0x07 >;
				brcm,pull = < 0x00 0x02 0x02 0x02 0x02 0x02 >;
				phandle = < 0x2a >;
			};

			emmc_gpio48 {
				brcm,pins = < 0x30 0x31 0x32 0x33 0x34 0x35 >;
				brcm,function = < 0x07 >;
				phandle = < 0x2b >;
			};

			gpclk0_gpio4 {
				brcm,pins = < 0x04 >;
				brcm,function = < 0x04 >;
				phandle = < 0x2c >;
			};

			gpclk1_gpio5 {
				brcm,pins = < 0x05 >;
				brcm,function = < 0x04 >;
				phandle = < 0x2d >;
			};

			gpclk1_gpio42 {
				brcm,pins = < 0x2a >;
				brcm,function = < 0x04 >;
				phandle = < 0x2e >;
			};

			gpclk1_gpio44 {
				brcm,pins = < 0x2c >;
				brcm,function = < 0x04 >;
				phandle = < 0x2f >;
			};

			gpclk2_gpio6 {
				brcm,pins = < 0x06 >;
				brcm,function = < 0x04 >;
				phandle = < 0x30 >;
			};

			gpclk2_gpio43 {
				brcm,pins = < 0x2b >;
				brcm,function = < 0x04 >;
				brcm,pull = < 0x00 >;
				phandle = < 0x31 >;
			};

			i2c0_gpio0 {
				brcm,pins = < 0x00 0x01 >;
				brcm,function = < 0x04 >;
				phandle = < 0x32 >;
			};

			i2c0_gpio28 {
				brcm,pins = < 0x1c 0x1d >;
				brcm,function = < 0x04 >;
				phandle = < 0x33 >;
			};

			i2c0_gpio44 {
				brcm,pins = < 0x2c 0x2d >;
				brcm,function = < 0x05 >;
				phandle = < 0x34 >;
			};

			i2c1_gpio2 {
				brcm,pins = < 0x02 0x03 >;
				brcm,function = < 0x04 >;
				phandle = < 0x35 >;
			};

			i2c1_gpio44 {
				brcm,pins = < 0x2c 0x2d >;
				brcm,function = < 0x06 >;
				phandle = < 0x36 >;
			};

			jtag_gpio22 {
				brcm,pins = < 0x16 0x17 0x18 0x19 0x1a 0x1b >;
				brcm,function = < 0x03 >;
				phandle = < 0x37 >;
			};

			pcm_gpio18 {
				brcm,pins = < 0x12 0x13 0x14 0x15 >;
				brcm,function = < 0x04 >;
				phandle = < 0x38 >;
			};

			pcm_gpio28 {
				brcm,pins = < 0x1c 0x1d 0x1e 0x1f >;
				brcm,function = < 0x06 >;
				phandle = < 0x39 >;
			};

			pwm0_gpio12 {
				brcm,pins = < 0x0c >;
				brcm,function = < 0x04 >;
				phandle = < 0x3a >;
			};

			pwm0_gpio18 {
				brcm,pins = < 0x12 >;
				brcm,function = < 0x02 >;
				phandle = < 0x3b >;
			};

			pwm0_gpio40 {
				brcm,pins = < 0x28 >;
				brcm,function = < 0x04 >;
				phandle = < 0x3c >;
			};

			pwm1_gpio13 {
				brcm,pins = < 0x0d >;
				brcm,function = < 0x04 >;
				phandle = < 0x3d >;
			};

			pwm1_gpio19 {
				brcm,pins = < 0x13 >;
				brcm,function = < 0x02 >;
				phandle = < 0x3e >;
			};

			pwm1_gpio41 {
				brcm,pins = < 0x29 >;
				brcm,function = < 0x04 >;
				phandle = < 0x3f >;
			};

			pwm1_gpio45 {
				brcm,pins = < 0x2d >;
				brcm,function = < 0x04 >;
				phandle = < 0x40 >;
			};

			sdhost_gpio48 {
				brcm,pins = < 0x30 0x31 0x32 0x33 0x34 0x35 >;
				brcm,function = < 0x04 >;
				phandle = < 0x09 >;
			};

			spi0_gpio7 {
				brcm,pins = < 0x07 0x08 0x09 0x0a 0x0b >;
				brcm,function = < 0x04 >;
				phandle = < 0x41 >;
			};

			spi0_gpio35 {
				brcm,pins = < 0x23 0x24 0x25 0x26 0x27 >;
				brcm,function = < 0x04 >;
				phandle = < 0x42 >;
			};

			spi1_gpio16 {
				brcm,pins = < 0x10 0x11 0x12 0x13 0x14 0x15 >;
				brcm,function = < 0x03 >;
				phandle = < 0x43 >;
			};

			spi2_gpio40 {
				brcm,pins = < 0x28 0x29 0x2a 0x2b 0x2c 0x2d >;
				brcm,function = < 0x03 >;
				phandle = < 0x44 >;
			};

			uart0_gpio14 {
				brcm,pins = < 0x0e 0x0f >;
				brcm,function = < 0x04 >;
				phandle = < 0x45 >;
			};

			uart0_ctsrts_gpio16 {
				brcm,pins = < 0x10 0x11 >;
				brcm,function = < 0x07 >;
				phandle = < 0x46 >;
			};

			uart0_ctsrts_gpio30 {
				brcm,pins = < 0x1e 0x1f >;
				brcm,function = < 0x07 >;
				brcm,pull = < 0x02 0x00 >;
				phandle = < 0x47 >;
			};

			uart0_gpio32 {
				brcm,pins = < 0x20 0x21 >;
				brcm,function = < 0x07 >;
				brcm,pull = < 0x00 0x02 >;
				phandle = < 0x48 >;
			};

			uart0_gpio36 {
				brcm,pins = < 0x24 0x25 >;
				brcm,function = < 0x06 >;
				phandle = < 0x49 >;
			};

			uart0_ctsrts_gpio38 {
				brcm,pins = < 0x26 0x27 >;
				brcm,function = < 0x06 >;
				phandle = < 0x4a >;
			};

			uart1_gpio14 {
				brcm,pins = < 0x0e 0x0f >;
				brcm,function = < 0x02 >;
				phandle = < 0x4b >;
			};

			uart1_ctsrts_gpio16 {
				brcm,pins = < 0x10 0x11 >;
				brcm,function = < 0x02 >;
				phandle = < 0x4c >;
			};

			uart1_gpio32 {
				brcm,pins = < 0x20 0x21 >;
				brcm,function = < 0x02 >;
				phandle = < 0x4d >;
			};

			uart1_ctsrts_gpio30 {
				brcm,pins = < 0x1e 0x1f >;
				brcm,function = < 0x02 >;
				phandle = < 0x4e >;
			};

			uart1_gpio40 {
				brcm,pins = < 0x28 0x29 >;
				brcm,function = < 0x02 >;
				phandle = < 0x4f >;
			};

			uart1_ctsrts_gpio42 {
				brcm,pins = < 0x2a 0x2b >;
				brcm,function = < 0x02 >;
				phandle = < 0x50 >;
			};

			i2c_slave_gpio18 {
				brcm,pins = < 0x12 0x13 0x14 0x15 >;
				brcm,function = < 0x07 >;
				phandle = < 0x51 >;
			};

			jtag_gpio4 {
				brcm,pins = < 0x04 0x05 0x06 0x0c 0x0d >;
				brcm,function = < 0x02 >;
				phandle = < 0x52 >;
			};

			dpi_18bit_gpio0 {
				brcm,pins = < 0x00 0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x15 >;
				brcm,function = < 0x06 >;
				phandle = < 0x53 >;
			};

			spi0_pins {
				brcm,pins = < 0x09 0x0a 0x0b >;
				brcm,function = < 0x04 >;
				phandle = < 0x0b >;
			};

			spi0_cs_pins {
				brcm,pins = < 0x08 0x07 >;
				brcm,function = < 0x06 >;
				phandle = < 0x0c >;
			};

			i2c0 {
				brcm,pins = < 0x00 0x01 >;
				brcm,function = < 0x04 >;
				phandle = < 0x0e >;
			};

			i2c1 {
				brcm,pins = < 0x02 0x03 >;
				brcm,function = < 0x04 >;
				phandle = < 0x11 >;
			};

			i2s {
				brcm,pins = < 0x12 0x13 0x14 0x15 >;
				brcm,function = < 0x04 >;
				phandle = < 0x0a >;
			};

			audio_pins {
				brcm,pins;
				brcm,function;
				phandle = < 0x16 >;
			};
		};

		serial@7e201000 {
			compatible = "brcm,bcm2835-pl011\0arm,pl011\0arm,primecell";
			reg = < 0x7e201000 0x200 >;
			interrupts = < 0x02 0x19 >;
			clocks = < 0x03 0x13 0x03 0x14 >;
			clock-names = "uartclk\0apb_pclk";
			arm,primecell-periphid = < 0x241011 >;
			cts-event-workaround;
			status = "okay";
			phandle = < 0x17 >;
		};

		mmc@7e202000 {
			compatible = "brcm,bcm2835-sdhost";
			reg = < 0x7e202000 0x100 >;
			interrupts = < 0x02 0x18 >;
			clocks = < 0x03 0x14 >;
			dmas = < 0x08 0x2000000d >;
			dma-names = "rx-tx";
			status = "okay";
			pinctrl-names = "default";
			pinctrl-0 = < 0x09 >;
			bus-width = < 0x04 >;
			brcm,overclock-50 = < 0x00 >;
			brcm,pio-limit = < 0x01 >;
			phandle = < 0x20 >;
		};

		i2s@7e203000 {
			compatible = "brcm,bcm2835-i2s";
			reg = < 0x7e203000 0x24 >;
			clocks = < 0x03 0x1f >;
			dmas = < 0x08 0x02 0x08 0x03 >;
			dma-names = "tx\0rx";
			status = "disabled";
			#sound-dai-cells = < 0x00 >;
			pinctrl-names = "default";
			pinctrl-0 = < 0x0a >;
			phandle = < 0x19 >;
		};

		spi@7e204000 {
			compatible = "brcm,bcm2835-spi";
			reg = < 0x7e204000 0x200 >;
			interrupts = < 0x02 0x16 >;
			clocks = < 0x03 0x14 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			dmas = < 0x08 0x06 0x08 0x07 >;
			dma-names = "tx\0rx";
			pinctrl-names = "default";
			pinctrl-0 = < 0x0b 0x0c >;
			cs-gpios = < 0x0d 0x08 0x01 0x0d 0x07 0x01 >;
			phandle = < 0x1a >;

			spidev@0 {
				compatible = "spidev";
				reg = < 0x00 >;
				#address-cells = < 0x01 >;
				#size-cells = < 0x00 >;
				spi-max-frequency = < 0x7735940 >;
				phandle = < 0x54 >;
			};

			spidev@1 {
				compatible = "spidev";
				reg = < 0x01 >;
				#address-cells = < 0x01 >;
				#size-cells = < 0x00 >;
				spi-max-frequency = < 0x7735940 >;
				phandle = < 0x55 >;
			};
		};

		i2c@7e205000 {
			compatible = "brcm,bcm2835-i2c";
			reg = < 0x7e205000 0x200 >;
			interrupts = < 0x02 0x15 >;
			clocks = < 0x03 0x14 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			pinctrl-names = "default";
			pinctrl-0 = < 0x0e >;
			clock-frequency = < 0x186a0 >;
			phandle = < 0x1b >;
		};

		pixelvalve@7e206000 {
			compatible = "brcm,bcm2835-pixelvalve0";
			reg = < 0x7e206000 0x100 >;
			interrupts = < 0x02 0x0d >;
			status = "disabled";
			phandle = < 0x56 >;
		};

		pixelvalve@7e207000 {
			compatible = "brcm,bcm2835-pixelvalve1";
			reg = < 0x7e207000 0x100 >;
			interrupts = < 0x02 0x0e >;
			status = "disabled";
			phandle = < 0x57 >;
		};

		dpi@7e208000 {
			compatible = "brcm,bcm2835-dpi";
			reg = < 0x7e208000 0x8c >;
			clocks = < 0x03 0x14 0x03 0x2c >;
			clock-names = "core\0pixel";
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			phandle = < 0x58 >;
		};

		dsi@7e209000 {
			compatible = "brcm,bcm2835-dsi0";
			reg = < 0x7e209000 0x78 >;
			interrupts = < 0x02 0x04 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			#clock-cells = < 0x01 >;
			clocks = < 0x03 0x20 0x03 0x2f 0x03 0x31 >;
			clock-names = "phy\0escape\0pixel";
			clock-output-names = "dsi0_byte\0dsi0_ddr2\0dsi0_ddr";
			phandle = < 0x05 >;
		};

		aux@7e215000 {
			compatible = "brcm,bcm2835-aux";
			#clock-cells = < 0x01 >;
			reg = < 0x7e215000 0x08 >;
			clocks = < 0x03 0x14 >;
			phandle = < 0x0f >;
		};

		serial@7e215040 {
			compatible = "brcm,bcm2835-aux-uart";
			reg = < 0x7e215040 0x40 >;
			interrupts = < 0x01 0x1d >;
			clocks = < 0x0f 0x00 >;
			status = "disabled";
			phandle = < 0x18 >;
		};

		spi@7e215080 {
			compatible = "brcm,bcm2835-aux-spi";
			reg = < 0x7e215080 0x40 >;
			interrupts = < 0x01 0x1d >;
			clocks = < 0x0f 0x01 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			phandle = < 0x59 >;
		};

		spi@7e2150c0 {
			compatible = "brcm,bcm2835-aux-spi";
			reg = < 0x7e2150c0 0x40 >;
			interrupts = < 0x01 0x1d >;
			clocks = < 0x0f 0x02 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			phandle = < 0x5a >;
		};

		pwm@7e20c000 {
			compatible = "brcm,bcm2835-pwm";
			reg = < 0x7e20c000 0x28 >;
			clocks = < 0x03 0x1e >;
			assigned-clocks = < 0x03 0x1e >;
			assigned-clock-rates = < 0x989680 >;
			#pwm-cells = < 0x02 >;
			status = "disabled";
			phandle = < 0x5b >;
		};

		hvs@7e400000 {
			compatible = "brcm,bcm2835-hvs";
			reg = < 0x7e400000 0x6000 >;
			interrupts = < 0x02 0x01 >;
			status = "disabled";
			phandle = < 0x5c >;
		};

		dsi@7e700000 {
			compatible = "brcm,bcm2835-dsi1";
			reg = < 0x7e700000 0x8c >;
			interrupts = < 0x02 0x0c >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			#clock-cells = < 0x01 >;
			clocks = < 0x03 0x23 0x03 0x30 0x03 0x32 >;
			clock-names = "phy\0escape\0pixel";
			clock-output-names = "dsi1_byte\0dsi1_ddr2\0dsi1_ddr";
			status = "disabled";
			phandle = < 0x06 >;
		};

		csi@7e800000 {
			compatible = "brcm,bcm2835-unicam";
			reg = < 0x7e800000 0x800 0x7e802000 0x04 >;
			interrupts = < 0x02 0x06 >;
			clocks = < 0x03 0x2d >;
			clock-names = "lp";
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			#clock-cells = < 0x01 >;
			status = "disabled";
			power-domains = < 0x10 0x0c >;
			phandle = < 0x5d >;

			port {

				endpoint {
					data-lanes = < 0x01 0x02 >;
				};
			};
		};

		csi@7e801000 {
			compatible = "brcm,bcm2835-unicam";
			reg = < 0x7e801000 0x800 0x7e802004 0x04 >;
			interrupts = < 0x02 0x07 >;
			clocks = < 0x03 0x2e >;
			clock-names = "lp";
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			#clock-cells = < 0x01 >;
			status = "disabled";
			power-domains = < 0x10 0x0d >;
			phandle = < 0x5e >;

			port {

				endpoint {
					data-lanes = < 0x01 0x02 0x03 0x04 >;
				};
			};
		};

		i2c@7e804000 {
			compatible = "brcm,bcm2835-i2c";
			reg = < 0x7e804000 0x1000 >;
			interrupts = < 0x02 0x15 >;
			clocks = < 0x03 0x14 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			pinctrl-names = "default";
			pinctrl-0 = < 0x11 >;
			clock-frequency = < 0x186a0 >;
			phandle = < 0x1c >;
		};

		i2c@7e805000 {
			compatible = "brcm,bcm2835-i2c";
			reg = < 0x7e805000 0x1000 >;
			interrupts = < 0x02 0x15 >;
			clocks = < 0x03 0x14 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			status = "disabled";
			clock-frequency = < 0x186a0 >;
			phandle = < 0x12 >;
		};

		vec@7e806000 {
			compatible = "brcm,bcm2835-vec";
			reg = < 0x7e806000 0x1000 >;
			clocks = < 0x03 0x18 >;
			interrupts = < 0x02 0x1b >;
			status = "disabled";
			phandle = < 0x5f >;
		};

		pixelvalve@7e807000 {
			compatible = "brcm,bcm2835-pixelvalve2";
			reg = < 0x7e807000 0x100 >;
			interrupts = < 0x02 0x0a >;
			status = "disabled";
			phandle = < 0x60 >;
		};

		hdmi@7e902000 {
			compatible = "brcm,bcm2835-hdmi";
			reg = < 0x7e902000 0x600 0x7e808000 0x100 >;
			interrupts = < 0x02 0x08 0x02 0x09 >;
			ddc = < 0x12 >;
			clocks = < 0x03 0x10 0x03 0x19 >;
			clock-names = "pixel\0hdmi";
			dmas = < 0x08 0x11 >;
			dma-names = "audio-rx";
			status = "disabled";
			power-domains = < 0x10 0x05 >;
			hpd-gpios = < 0x0d 0x2e 0x00 >;
			phandle = < 0x61 >;
		};

		usb@7e980000 {
			compatible = "brcm,bcm2708-usb";
			reg = < 0x7e980000 0x10000 0x7e006000 0x1000 >;
			interrupts = < 0x01 0x09 0x02 0x00 >;
			#address-cells = < 0x01 >;
			#size-cells = < 0x00 >;
			clocks = < 0x13 >;
			clock-names = "otg";
			phys = < 0x14 >;
			phy-names = "usb2-phy";
			interrupt-names = "usb\0soft";
			power-domains = < 0x10 0x06 >;
			phandle = < 0x62 >;
		};

		gpu {
			compatible = "brcm,bcm2835-vc4";
			status = "disabled";
			phandle = < 0x63 >;
		};

		timer@7e003000 {
			compatible = "brcm,bcm2835-system-timer";
			reg = < 0x7e003000 0x1000 >;
			interrupts = < 0x01 0x00 0x01 0x01 0x01 0x02 0x01 0x03 >;
			clock-frequency = < 0xf4240 >;
		};

		interrupt-controller@7e00b200 {
			compatible = "brcm,bcm2835-armctrl-ic";
			reg = < 0x7e00b200 0x200 >;
			interrupt-controller;
			#interrupt-cells = < 0x02 >;
			phandle = < 0x01 >;
		};

		thermal@7e212000 {
			compatible = "brcm,bcm2835-thermal";
			reg = < 0x7e212000 0x08 >;
			clocks = < 0x03 0x1b >;
			#thermal-sensor-cells = < 0x00 >;
			status = "okay";
			phandle = < 0x02 >;
		};

		v3d@7ec00000 {
			compatible = "brcm,vc4-v3d";
			reg = < 0x7ec00000 0x1000 >;
			interrupts = < 0x01 0x0a >;
			power-domains = < 0x10 0x0a >;
			status = "disabled";
			phandle = < 0x64 >;
		};

		mmc@7e300000 {
			compatible = "brcm,bcm2835-mmc\0brcm,bcm2835-sdhci";
			reg = < 0x7e300000 0x100 >;
			interrupts = < 0x02 0x1e >;
			clocks = < 0x03 0x1c >;
			dmas = < 0x08 0x0b >;
			dma-names = "rx-tx";
			brcm,overclock-50 = < 0x00 >;
			status = "disabled";
			phandle = < 0x21 >;
		};

		mmcnr@7e300000 {
			compatible = "brcm,bcm2835-mmc\0brcm,bcm2835-sdhci";
			reg = < 0x7e300000 0x100 >;
			interrupts = < 0x02 0x1e >;
			clocks = < 0x03 0x1c >;
			dmas = < 0x08 0x0b >;
			dma-names = "rx-tx";
			brcm,overclock-50 = < 0x00 >;
			non-removable;
			status = "disabled";
			phandle = < 0x22 >;
		};

		firmwarekms@7e600000 {
			compatible = "raspberrypi,rpi-firmware-kms";
			reg = < 0x7e600000 0x100 >;
			interrupts = < 0x02 0x10 >;
			brcm,firmware = < 0x07 >;
			status = "disabled";
			phandle = < 0x65 >;
		};

		smi@7e600000 {
			compatible = "brcm,bcm2835-smi";
			reg = < 0x7e600000 0x100 >;
			interrupts = < 0x02 0x10 >;
			clocks = < 0x03 0x2a >;
			assigned-clocks = < 0x03 0x2a >;
			assigned-clock-rates = < 0x7735940 >;
			dmas = < 0x08 0x04 >;
			dma-names = "rx-tx";
			status = "disabled";
			phandle = < 0x66 >;
		};

		axiperf {
			compatible = "brcm,bcm2835-axiperf";
			reg = < 0x7e009800 0x100 0x7ee08000 0x100 >;
			firmware = < 0x07 >;
			status = "disabled";
			phandle = < 0x23 >;
		};

		gpiomem {
			compatible = "brcm,bcm2835-gpiomem";
			reg = < 0x7e200000 0x1000 >;
		};

		firmware {
			compatible = "raspberrypi,bcm2835-firmware\0simple-bus";
			#address-cells = < 0x00 >;
			#size-cells = < 0x00 >;
			mboxes = < 0x15 >;
			phandle = < 0x07 >;
		};

		power {
			compatible = "raspberrypi,bcm2835-power";
			firmware = < 0x07 >;
			#power-domain-cells = < 0x01 >;
			phandle = < 0x10 >;
		};

		fb {
			compatible = "brcm,bcm2708-fb";
			firmware = < 0x07 >;
			status = "okay";
			phandle = < 0x67 >;
		};

		mailbox@7e00b840 {
			compatible = "brcm,bcm2835-vchiq";
			reg = < 0x7e00b840 0x3c >;
			interrupts = < 0x00 0x02 >;
			phandle = < 0x68 >;
		};

		vcsm {
			compatible = "raspberrypi,bcm2835-vcsm";
			firmware = < 0x07 >;
			status = "okay";
			phandle = < 0x69 >;
		};

		audio {
			compatible = "brcm,bcm2835-audio";
			brcm,pwm-channels = < 0x08 >;
			status = "disabled";
			pinctrl-names = "default";
			pinctrl-0 = < 0x16 >;
			phandle = < 0x1d >;
		};

		sound {
			status = "disabled";
			phandle = < 0x6a >;
		};
	};

	clocks {
		compatible = "simple-bus";
		#address-cells = < 0x01 >;
		#size-cells = < 0x00 >;

		clock@3 {
			compatible = "fixed-clock";
			reg = < 0x03 >;
			#clock-cells = < 0x00 >;
			clock-output-names = "osc";
			clock-frequency = < 0x124f800 >;
			phandle = < 0x04 >;
		};

		clock@4 {
			compatible = "fixed-clock";
			reg = < 0x04 >;
			#clock-cells = < 0x00 >;
			clock-output-names = "otg";
			clock-frequency = < 0x1c9c3800 >;
			phandle = < 0x13 >;
		};
	};

	phy {
		compatible = "usb-nop-xceiv";
		#phy-cells = < 0x00 >;
		phandle = < 0x14 >;
	};

	arm-pmu {
		compatible = "arm,arm1176-pmu";
	};

	fixedregulator_5v0 {
		compatible = "regulator-fixed";
		regulator-name = "5v0";
		regulator-min-microvolt = < 0x4c4b40 >;
		regulator-max-microvolt = < 0x4c4b40 >;
		regulator-always-on;
		phandle = < 0x6b >;
	};

	fixedregulator_3v3 {
		compatible = "regulator-fixed";
		regulator-name = "3v3";
		regulator-min-microvolt = < 0x325aa0 >;
		regulator-max-microvolt = < 0x325aa0 >;
		regulator-always-on;
		phandle = < 0x6c >;
	};

	__overrides__ {
		cam0-pwdn-ctrl;
		cam0-pwdn;
		cam0-led-ctrl;
		cam0-led;
		cache_line_size;
		uart0 = [ 00 00 00 17 73 74 61 74 75 73 00 ];
		uart1 = [ 00 00 00 18 73 74 61 74 75 73 00 ];
		i2s = [ 00 00 00 19 73 74 61 74 75 73 00 ];
		spi = [ 00 00 00 1a 73 74 61 74 75 73 00 ];
		i2c0 = [ 00 00 00 1b 73 74 61 74 75 73 00 ];
		i2c1 = [ 00 00 00 1c 73 74 61 74 75 73 00 ];
		i2c2_iknowwhatimdoing = [ 00 00 00 12 73 74 61 74 75 73 00 ];
		i2c0_baudrate = [ 00 00 00 1b 63 6c 6f 63 6b 2d 66 72 65 71 75 65 6e 63 79 3a 30 00 ];
		i2c1_baudrate = [ 00 00 00 1c 63 6c 6f 63 6b 2d 66 72 65 71 75 65 6e 63 79 3a 30 00 ];
		i2c2_baudrate = [ 00 00 00 12 63 6c 6f 63 6b 2d 66 72 65 71 75 65 6e 63 79 3a 30 00 ];
		audio = [ 00 00 00 1d 73 74 61 74 75 73 00 ];
		watchdog = [ 00 00 00 1e 73 74 61 74 75 73 00 ];
		random = [ 00 00 00 1f 73 74 61 74 75 73 00 ];
		sd_overclock = "\0\0\0 brcm,overclock-50:0";
		sd_force_pio = "\0\0\0 brcm,force-pio?";
		sd_pio_limit = "\0\0\0 brcm,pio-limit:0";
		sd_debug = "\0\0\0 brcm,debug";
		sdio_overclock = "\0\0\0!brcm,overclock-50:0\0\0\0\0\"brcm,overclock-50:0";
		axiperf = "\0\0\0#status";
		arm_freq;
		act_led_gpio = "\0\0\0$gpios:4";
		act_led_activelow = "\0\0\0$gpios:8";
		act_led_trigger = "\0\0\0$linux,default-trigger";
	};

	memory {
		device_type = "memory";
		reg = < 0x00 0x00 >;
	};

	leds {
		compatible = "gpio-leds";
		phandle = < 0x6d >;

		act {
			label = "led0";
			linux,default-trigger = "mmc0";
			gpios = < 0x0d 0x2f 0x00 >;
			phandle = < 0x24 >;
		};
	};

	__symbols__ {
		cpu_thermal = "/thermal-zones/cpu-thermal";
		soc = "/soc";
		txp = "/soc/txp@7e004000";
		dma = "/soc/dma@7e007000";
		watchdog = "/soc/watchdog@7e100000";
		clocks = "/soc/cprman@7e101000";
		random = "/soc/rng@7e104000";
		rng = "/soc/rng@7e104000";
		mailbox = "/soc/mailbox@7e00b880";
		gpio = "/soc/gpio@7e200000";
		dpi_gpio0 = "/soc/gpio@7e200000/dpi_gpio0";
		emmc_gpio22 = "/soc/gpio@7e200000/emmc_gpio22";
		emmc_gpio34 = "/soc/gpio@7e200000/emmc_gpio34";
		emmc_gpio48 = "/soc/gpio@7e200000/emmc_gpio48";
		gpclk0_gpio4 = "/soc/gpio@7e200000/gpclk0_gpio4";
		gpclk1_gpio5 = "/soc/gpio@7e200000/gpclk1_gpio5";
		gpclk1_gpio42 = "/soc/gpio@7e200000/gpclk1_gpio42";
		gpclk1_gpio44 = "/soc/gpio@7e200000/gpclk1_gpio44";
		gpclk2_gpio6 = "/soc/gpio@7e200000/gpclk2_gpio6";
		gpclk2_gpio43 = "/soc/gpio@7e200000/gpclk2_gpio43";
		i2c0_gpio0 = "/soc/gpio@7e200000/i2c0_gpio0";
		i2c0_gpio28 = "/soc/gpio@7e200000/i2c0_gpio28";
		i2c0_gpio44 = "/soc/gpio@7e200000/i2c0_gpio44";
		i2c1_gpio2 = "/soc/gpio@7e200000/i2c1_gpio2";
		i2c1_gpio44 = "/soc/gpio@7e200000/i2c1_gpio44";
		jtag_gpio22 = "/soc/gpio@7e200000/jtag_gpio22";
		pcm_gpio18 = "/soc/gpio@7e200000/pcm_gpio18";
		pcm_gpio28 = "/soc/gpio@7e200000/pcm_gpio28";
		pwm0_gpio12 = "/soc/gpio@7e200000/pwm0_gpio12";
		pwm0_gpio18 = "/soc/gpio@7e200000/pwm0_gpio18";
		pwm0_gpio40 = "/soc/gpio@7e200000/pwm0_gpio40";
		pwm1_gpio13 = "/soc/gpio@7e200000/pwm1_gpio13";
		pwm1_gpio19 = "/soc/gpio@7e200000/pwm1_gpio19";
		pwm1_gpio41 = "/soc/gpio@7e200000/pwm1_gpio41";
		pwm1_gpio45 = "/soc/gpio@7e200000/pwm1_gpio45";
		sdhost_pins = "/soc/gpio@7e200000/sdhost_gpio48";
		sdhost_gpio48 = "/soc/gpio@7e200000/sdhost_gpio48";
		spi0_gpio7 = "/soc/gpio@7e200000/spi0_gpio7";
		spi0_gpio35 = "/soc/gpio@7e200000/spi0_gpio35";
		spi1_gpio16 = "/soc/gpio@7e200000/spi1_gpio16";
		spi2_gpio40 = "/soc/gpio@7e200000/spi2_gpio40";
		uart0_gpio14 = "/soc/gpio@7e200000/uart0_gpio14";
		uart0_ctsrts_gpio16 = "/soc/gpio@7e200000/uart0_ctsrts_gpio16";
		uart0_ctsrts_gpio30 = "/soc/gpio@7e200000/uart0_ctsrts_gpio30";
		uart0_gpio32 = "/soc/gpio@7e200000/uart0_gpio32";
		uart0_gpio36 = "/soc/gpio@7e200000/uart0_gpio36";
		uart0_ctsrts_gpio38 = "/soc/gpio@7e200000/uart0_ctsrts_gpio38";
		uart1_gpio14 = "/soc/gpio@7e200000/uart1_gpio14";
		uart1_ctsrts_gpio16 = "/soc/gpio@7e200000/uart1_ctsrts_gpio16";
		uart1_gpio32 = "/soc/gpio@7e200000/uart1_gpio32";
		uart1_ctsrts_gpio30 = "/soc/gpio@7e200000/uart1_ctsrts_gpio30";
		uart1_gpio40 = "/soc/gpio@7e200000/uart1_gpio40";
		uart1_ctsrts_gpio42 = "/soc/gpio@7e200000/uart1_ctsrts_gpio42";
		i2c_slave_gpio18 = "/soc/gpio@7e200000/i2c_slave_gpio18";
		jtag_gpio4 = "/soc/gpio@7e200000/jtag_gpio4";
		dpi_18bit_gpio0 = "/soc/gpio@7e200000/dpi_18bit_gpio0";
		spi0_pins = "/soc/gpio@7e200000/spi0_pins";
		spi0_cs_pins = "/soc/gpio@7e200000/spi0_cs_pins";
		i2c0_pins = "/soc/gpio@7e200000/i2c0";
		i2c1_pins = "/soc/gpio@7e200000/i2c1";
		i2s_pins = "/soc/gpio@7e200000/i2s";
		audio_pins = "/soc/gpio@7e200000/audio_pins";
		uart0 = "/soc/serial@7e201000";
		sdhost = "/soc/mmc@7e202000";
		i2s = "/soc/i2s@7e203000";
		spi0 = "/soc/spi@7e204000";
		spi = "/soc/spi@7e204000";
		spidev0 = "/soc/spi@7e204000/spidev@0";
		spidev1 = "/soc/spi@7e204000/spidev@1";
		i2c0 = "/soc/i2c@7e205000";
		pixelvalve0 = "/soc/pixelvalve@7e206000";
		pixelvalve1 = "/soc/pixelvalve@7e207000";
		dpi = "/soc/dpi@7e208000";
		dsi0 = "/soc/dsi@7e209000";
		aux = "/soc/aux@7e215000";
		uart1 = "/soc/serial@7e215040";
		spi1 = "/soc/spi@7e215080";
		spi2 = "/soc/spi@7e2150c0";
		pwm = "/soc/pwm@7e20c000";
		hvs = "/soc/hvs@7e400000";
		dsi1 = "/soc/dsi@7e700000";
		csi0 = "/soc/csi@7e800000";
		csi1 = "/soc/csi@7e801000";
		i2c1 = "/soc/i2c@7e804000";
		i2c2 = "/soc/i2c@7e805000";
		vec = "/soc/vec@7e806000";
		pixelvalve2 = "/soc/pixelvalve@7e807000";
		hdmi = "/soc/hdmi@7e902000";
		usb = "/soc/usb@7e980000";
		vc4 = "/soc/gpu";
		intc = "/soc/interrupt-controller@7e00b200";
		thermal = "/soc/thermal@7e212000";
		v3d = "/soc/v3d@7ec00000";
		mmc = "/soc/mmc@7e300000";
		mmcnr = "/soc/mmcnr@7e300000";
		firmwarekms = "/soc/firmwarekms@7e600000";
		smi = "/soc/smi@7e600000";
		axiperf = "/soc/axiperf";
		firmware = "/soc/firmware";
		power = "/soc/power";
		fb = "/soc/fb";
		vchiq = "/soc/mailbox@7e00b840";
		vcsm = "/soc/vcsm";
		audio = "/soc/audio";
		sound = "/soc/sound";
		clk_osc = "/clocks/clock@3";
		clk_usb = "/clocks/clock@4";
		usbphy = "/phy";
		vdd_5v0_reg = "/fixedregulator_5v0";
		vdd_3v3_reg = "/fixedregulator_3v3";
		leds = "/leds";
		act_led = "/leds/act";
	};
};
EOF
dtc -W no-mboxes_property -W no-msi_parent_property -W no-phys_property -W no-resets_property -W no-thermal_sensors_property -W no-power_domains_property -W no-dmas_property -W no-unit_address_vs_reg -W no-unique_unit_address -W no-gpios_property -W no-avoid_unnecessary_addr_size -W no-clocks_property -I dts -O dtb -o /boot/bcm2708-rpi-cm.dtb /boot/bcm2708-rpi-cm.dts
}

do_cm_dtb
