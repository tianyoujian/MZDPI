    cd ~/

    git clone https://github.com/tianyoujian/MZDPI.git

    cd MZDPI/vga

    sudo chmod +x mzdpi-vga-autoinstall-online

    sudo ./mzdpi-vga-autoinstall-online

    sudo reboot
    
    #How to solve the blue/yellow on Raspberry pi 4?
    Please run the following shell:
    sudo raspi-gpio set 8 a2
    sudo raspi-gpio set 7 a2
