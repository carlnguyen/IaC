#!/bin/bash

GIT_URL='https://github.com/carlnguyen/ansible.git'

#generate ssh
# ssh-keygen -t rsa -b 4096 -P "P@ssword123" -f "mykey" -q

#install ansible
sudo apt-get -y update
sudo apt-get -y install software-properties-common
sudo apt-get -y update
sudo apt install ansible

# cd /tmp/ && mkdir -p ansible
# git init \
#     git remote add origin -f $GIT_URL \
#     git config core.sparsecheckout true

# echo LEMP >>.git/info/sparse-checkout

# git pull origin master

# cd ansible && ansible-playbook -i
