#!/bin/bash

sudo apt -y update
sudo apt -y install nginx
sudo apt-get -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get -y update
sudo apt-get -y install -y php7.3