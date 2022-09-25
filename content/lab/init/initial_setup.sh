#!/bin/sh

#disable cache
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

#install docker
sudo apt update
sudo apt -y install docker.io

##install kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.15.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/bin/kind


#allow current user to run docker
sudo usermod -aG docker $USER
sudo service ttyd restart
