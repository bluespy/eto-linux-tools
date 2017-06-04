#!/bin/sh
# Installation for network printer Epson L355 Series.
# It assumes that printer is located at 172.16.24.88

wget http://a1227.g.akamai.net/f/1227/40484/7d/download.ebz.epson.net/dsc/f/01/00/01/87/87/126d18060d9881eaed0ff545ad711bd4e642b62a/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_i386.deb -v -O epson-inkjet-printer-201207w_1.0.0-1lsb3.2_i386.deb
sudo apt-get -y install lsb && dpkg -i epson-inkjet-printer-201207w_1.0.0-1lsb3.2_i386.deb
sudo rm -rf epson-inkjet-printer-201207w_1.0.0-1lsb3.2_i386.deb
sudo lpadmin -p "Epson-L355" -v "socket://172.16.24.88" -m "Epson L355 Series" -P /usr/share/ppd/epson-inkjet-printer-201207w/Epson/Epson-L355_Series-epson-driver.ppd.gz -E
