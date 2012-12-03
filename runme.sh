#!/bin/bash

KEYFILE="sshkey/pxeboot"

if [ "$#" != 1 ]
then
	echo "Useage: 'runme.sh SERVERIP'"
	exit 1
fi

if ping -w 2 -c 1 "$1" > /dev/null
then 
  echo Can ping "$1"
else
  echo Cannot ping "$1" - exiting
  exit 1
fi


# Create temporary ssh key and push it to the server
# You must enter the password for root once
if [ ! -d sshkey ]
then
	mkdir sshkey
fi

if [ ! -f $KEYFILE ]
then
	ssh-keygen -t rsa -N "" -q -f $KEYFILE > sshkey/log1.txt
	echo "Created new key pair"
fi
ssh-copy-id -i $KEYFILE.pub root@$1 > sshkey/log2.txt
echo Copied public key to server

# Install nescessary packages
echo "Install packages..."
ssh -i $KEYFILE root@$1 'apt-get install tftpd-hpa syslinux dhcp3-server'


# Setup network interface for the internal boot network - must be eth1
echo "backup interfaces file"
ssh -i $KEYFILE root@$1 'cp --backup=numbered /etc/network/interfaces /etc/network/interfaces.old'
scp -i $KEYFILE interfaces root@$1:/etc/network/interfaces

echo "backup dhcpd.conf file"
ssh -i $KEYFILE root@$1 'cp --backup=numbered /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.old'
scp -i $KEYFILE dhcpd.conf root@192.168.122.64:/etc/dhcp/dhcpd.conf







 

