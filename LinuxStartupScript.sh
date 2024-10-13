#!/bin/bash
#echo "Starting to update and upgrade..........................."
#sudo apt-get update && sudo apt-get upgrade -y &&\
#echo "Starting to install ssh server..........................."
#sudo apt-get install openssh-server -y\
#echo "Starting to Docker Engine..........................."
if lsb_release -r | grep -q "Ubuntu"
then
    echo "Found Ubuntu."
else
  echo "Found somthing else."
fi
