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
mkdir sshkey


# Install nescessary packages

