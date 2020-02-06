#!/bin/bash

# Update
yum update -y
# Install neccessary utils and libraries 
yum install -y ncurses-devel make wget gcc bc bison flex elfutils-libelf-devel openssl-devel 
# Get kernel tarball
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.tar.xz
# Untar tarball
tar -xvf linux-5.5.tar.xz
cd linux-5.5/
# Make .config file
yes "" | sudo make oldconfig
# Make bzImage
make bzImage
# Compile and build kernel
make && make modules
# Install kernel and modules
make install && make modules_install
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
