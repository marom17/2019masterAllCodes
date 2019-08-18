#!/bin/bash
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.56.tar.gz
tar -zxf bcm2835-1.56.tar.gz
cd bcm2835-1.56
./configure
sudo make check
sudo make install
cd ..
git clone https://github.com/paulvha/twowire
cd twowire
sudo make install
cd ..
git clone https://github.com/marom17/cppDriverMaster2019
cd cppDriverMaster2019
make
chmod 755 pythonscd30.py
mv scd30 /home/pi
mv pythonscd30.py /home/pi
cd ..
rm bcm2835-1.56.tar.gz
rm -rf bcm2835-1.56
rm -rf twowire
rm -rf cppDriverMaster2019
pip3 install watchdog
crontab -l > mycron
echo "@reboot /home/pi/scd30 -w 2 -i 2 -l 0" >> mycron
echo "@reboot sleep 60 && cd /home/pi && python3 pythonscd30.py" >> mycron
echo "@reboot cd /home/pi && sudo updateNTP.sh"
echo "0 0 * * * sudo kill python3 && cd /home/pi && python3 pythonscd30.py"
crontab mycron
rm mycron
