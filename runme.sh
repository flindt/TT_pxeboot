#!/bin/bash

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

if [ ! -f ~/.ssh/pxeboot ]
then
	ssh-keygen -t rsa -N "" -q -f ~/.ssh/pxeboot > sshkey/log1.txt
fi
ssh-copy-id -i ~/.ssh/pxeboot.pub root@$1 > sshkey/log2.txt
echo Copied public key to server

# Install nescessary packages

