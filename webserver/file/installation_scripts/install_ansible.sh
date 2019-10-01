#!/bin/bash
apt update 
apt -y install software-properties-common dirmngr apt-transport-https lsb-release ca-certificates
add-apt-repository ppa:ansible/ansible -y
apt update
apt install -y ansible