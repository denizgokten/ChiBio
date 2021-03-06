cd ../../etc/ssh/
echo "PermitRootLogin yes" >> sshd_config
echo -e "root\nroot" | passwd root
sed -i 's@-w /var/lib/cloud9@-w /root/chibio@' /lib/systemd/system/cloud9.service
sed -i 's@1000@root@' /lib/systemd/system/cloud9.service
cd ..
echo -e "nameserver 8.8.8.8\nnameserver 8.8.4.4" >> resolv.conf
sudo /sbin/route add default gw 192.168.7.1
sudo apt-get update
mkdir ~/chibio
cd ~/../home/debian
cp cb.sh ~/chibio
cp app.py ~/chibio
cp static -r ~/chibio
cp templates -r ~/chibio
sudo apt --assume-yes install python-pip
pip install Gunicorn
pip install flask
pip install serial
pip install Adafruit_GPIO
pip install --user --upgrade setuptools
pip install simplejson
pip install smbus2
pip install numpy
cd ~/../tmp
pip download Adafruit_BBIO
tar xvzf Adafruit_BBIO-1.1.1.tar.gz
cd Adafruit_BBIO-1.1.1/
sed -i "s/'-Werror', //g" setup.py
python setup.py install
cd ~/../root/chibio
chmod +x cb.sh
reboot now
