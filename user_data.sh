#!/bin/bash

echo hello > /tmp/hello.txt

#Install nginx
sudo amazon-linux-extras install -y nginx1
sudo service nginx start