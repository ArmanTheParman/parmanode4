function udev {

if [[ $chip == "x86_64" ]] ; then
cd $tmp
curl -LO http://parman.org/downloadable/udev
sudo chmod +x $tmp/udev
sudo ./udev installudevrules
fi

if [[ $chip == "aarch64" ]] ; then
cd $tmp
curl -LO http://parman.org/downloadable/udev_aarch64
sudo chmod +x $tmp/udev_aarch64
sudo ./udev_aarch64 installudevrules
fi

sudo install -m 644 $pn/src/misc/udev/*.rules /etc/udev/rules.d >$dn
sudo udevadm control --reload >$dn
sudo udevadm trigger >$dn
sudo groupadd -f plugdev >$dn
sudo usermod -aG plugdev $USER >$dn

}


