#!/bin/bash
#
# Author: Bac Tran
#
echo "==============================================================="
echo "Starting to update and upgrade..........................."
sudo apt-get update && sudo apt-get upgrade -y
echo "==============================================================="

echo "==============================================================="
echo "Starting to install ssh server..........................."
sudo apt-get install openssh-server -y
sudo systemctl restart ssh
echo "==============================================================="

echo "==============================================================="
echo "Starting to install nano + htop + iftop"
sudo apt-get install nano -y
sudo apt install htop iftop -y
echo "==============================================================="

echo "==============================================================="
echo "Starting to install miniconda"
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-py310_25.5.1-0-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
echo "==============================================================="

echo "==============================================================="
echo "Starting to install Docker Engine..........................."
if lsb_release -i | grep -q "Ubuntu"
then
	echo "==============================================================="
 	echo "Found Ubuntu as Operating System..."
	echo "Installing Docker Engine now..."
 	echo "==============================================================="
	for pkg in docker.io docker-doc docker-compose docker-compose-v2\
	 podman-docker containerd runc; do sudo apt-get remove $pkg; done
	echo
	# Add Docker's official GPG key:
	 sudo apt-get update
	sudo apt-get install ca-certificates curl -y
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
  	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	echo
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
 	echo "==============================================================="
  	sudo usermod -aG docker $USER
   	#sudo newgrp docker
    	echo "==============================================================="
     	echo "==============================================================="
	echo "==============================================================="
	echo "Docker Engine Installation is completed."
 	echo "Please run command -- newgrp docker -- to initiate the change"
	echo "==============================================================="
 	echo "==============================================================="
  	echo "==============================================================="
elif cat /etc/os-release | grep -q "Debian"
then
	echo "==============================================================="
 	echo "Found Debian as Operating System..."
	echo -n "Installing Docker Engine now..."
 	echo "==============================================================="
	
	for pkg in docker.io docker-doc docker-compose\
	 podman-docker containerd runc; do sudo apt-get remove $pkg; done
	
	# Add Docker's official GPG key:
	# sudo apt-get update
	sudo apt-get install ca-certificates curl -y
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
  	"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  	$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  	sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

	echo "==============================================================="
  	sudo usermod -aG docker $USER
   	#sudo newgrp docker
  
	echo "==============================================================="
	echo "==============================================================="
	echo "============================================================="
	echo "Docker Enginer Installation is completed."
 	echo "Please run command -- newgrp docker -- to initiate the change if needed"
	echo "============================================================="
	echo "==============================================================="
	echo "==============================================================="
fi

echo "Restart in 5 ====="
sleep 1
echo "Restart in 4 ===="
sleep 1
echo "Restart in 3 ==="
sleep 1
echo "Restart in 2 =="
sleep 1
echo "Restart in 1 ="
sleep 1

sudo reboot
