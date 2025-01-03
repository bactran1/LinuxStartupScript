#!/bin/bash
echo "Starting to update and upgrade..........................."
sudo apt-get update && sudo apt-get upgrade -y

echo "Starting to install ssh server..........................."
sudo apt-get install openssh-server -y
sudo systemctl restart ssh

echo "Starting to install nano"
sudo apt-get install nano -y

echo "Starting to install Docker Engine..........................."
if lsb_release -i | grep -q "Ubuntu"
then
	echo "==============================================================="
 	echo "Found Ubuntu as Operating System..."
	echo -n "Installing Docker Engine now..."
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
  	sudo usermod -aG docker cse
   	sudo newgrp docker
	echo "==============================================================="
	echo "Docker Engine Installation is completed."
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
 
	echo
	echo
	echo "============================================================="
	echo "Docker Enginer Installation is completed."
	echo "============================================================="
	echo
	echo
fi
