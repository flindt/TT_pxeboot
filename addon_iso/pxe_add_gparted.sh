#!/bin/bash

wget http://sourceforge.net/projects/gparted/files/gparted-live-stable/0.14.0-1/gparted-live-0.14.0-1.zip/download

mv download  gparted-live-0.14.zip

mkdir -p /tmp/gparted; unzip gparted-live-*.zip -d /tmp/gparted/

sudo mkdir /tftpboot/gparted
sudo cp /tmp/gparted/live/{vmlinuz,initrd.img} /tftpboot/gparted/

sudo cp /tmp/gparted/live/filesystem.squashfs /var/www/


echo add this to the file /tftpboot/pxelinux.cfg
echo ====================================================
echo "label GParted Live"
echo "           MENU LABEL GParted Live"
echo "           kernel gparted/vmlinuz"
echo "           append initrd=gparted/initrd.img boot=live config union=aufs noswap noprompt vga=788 fetch=http://192.168.22.1/filesystem.squashfs"

