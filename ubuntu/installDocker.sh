#!/bin/sh

# Install docker in an ec2 instance.
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo docker version
echo logout and login will make docker executable without sudo.
