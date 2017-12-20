#!/bin/bash

TEAMCITY_SERVER_IMAGE=jetbrains/teamcity-server:latest

# Create data folder for Build Agent.
sudo mkdir /mnt
sudo mkdir /mnt/data
sudo mkdir /mnt/data/teamcity
sudo mkdir /mnt/data/logs
sudo mkdir /mnt/data/logs/teamcity
sudo mkdir /mnt/data/temp
sudo mkdir /mnt/data/temp/teamcity

# Try to download and install plugin: Node.js build runner
NODE_PLUGIN_URL=https://teamcity.jetbrains.com/guestAuth/repository/download/bt434/.lastSuccessful/jonnyzzz.node.zip
NODE_PLUGIN_PATH=/tmp/jonnyzzz.node.zip
if sudo test ! -e /mnt/data/teamcity/plugins/jonnyzzz.node.zip;
then
	sudo mkdir /mnt/data/teamcity/plugins
	wget $NODE_PLUGIN_URL -O $NODE_PLUGIN_PATH
	chmod 640 $NODE_PLUGIN_PATH
	sudo chown root:root $NODE_PLUGIN_PATH
	sudo mv $NODE_PLUGIN_PATH /mnt/data/teamcity/plugins/
fi

# Run a restartable TeamCity Server
sudo docker run -d \
  -v /mnt/data/teamcity:/data/teamcity_server/datadir \
  -v /mnt/data/logs/teamcity:/opt/teamcity/logs \
  -v /mnt/data/temp/teamcity:/opt/teamcity/temp \
  -p 80:8111 \
  --name teamcity-server \
  --restart unless-stopped \
  $TEAMCITY_SERVER_IMAGE
