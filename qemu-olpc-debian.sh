#!/bin/bash
## olpc vm script for ubuntu (>= 7.04) by Yannis Tsopokis
## go here for more info:
## http://tsopokis.gr (soon there will be an olpc section there)
## http://wiki.laptop.org/go/Emulating_the_XO/Quick_Start/Linux
## http://xs-dev.laptop.org/~cscott/olpc/streams/ship.2/build659/devel_ext3/olpc-redhat-stream-ship.2-build-659-20080229_1949-devel_ext3.img.bz2
link=http://xs-dev.laptop.org/~cscott/olpc/streams/ship.2/build659/devel_ext3/olpc-redhat-stream-ship.2-build-659-20080229_1949-devel_ext3.img.bz2
[ -f olpc-redhat-stream-ship.2-build-659-20080229_1949-devel_ext3.img ] || wget $link && bunzip2 olpc-redhat-stream-ship.2-build-659-20080229_1949-devel_ext3.img.bz2
dpkg --get-selections qemu 2>/dev/null | grep install || sudo apt-get install qemu
dpkg --get-selections kqemu-common 2>/dev/null | grep install || sudo apt-get install kqemu-common
dpkg --get-selections module-assistant 2>/dev/null | grep install || sudo apt-get install module-assistant
sudo module-assistant auto-install kqemu
sudo su -c "echo 'options kqemu major=0' > /etc/modprobe.d/kqemu"
sudo su -c 'echo KERNEL==\"kqemu\", NAME=\"%k\", MODE=\"0666\" > /etc/udev/rules.d/60-kqemu.rules'
sudo /sbin/modprobe kqemu major=0
qemu -kernel-kqemu -m 256 -soundhw es1370 -serial `tty` -net user -net nic,model=rtl8139 -hda olpc-redhat-stream-ship.2-build-659-20080229_1949-devel_ext3.img
