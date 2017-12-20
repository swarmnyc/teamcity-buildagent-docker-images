#!/bin/bash

# Get ec2's local ip address.
EC2_IPV4_LOCAL=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
TEAMCITY_SERVER_SWARM=34.224.141.66
TEAMCITY_SERVER_IP=$TEAMCITY_SERVER_SWARM #or ${EC2_IPV4_LOCAL}
TEAMCITY_IMAGE=swarmnyc/teamcity-agent:latest
AGENT_NAME=OnPremises-1

# Create data folder for Build Agent.
DATA_ROOT=`pwd`
sudo mkdir $DATA_ROOT/conf
sudo mkdir $DATA_ROOT/temp

# Run a restartable TeamCity Build Agent.
docker run -d \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $DATA_ROOT/conf:/data/teamcity_agent/conf \
  -v $DATA_ROOT/temp:/opt/teamcity/temp \
  -e SERVER_URL=${TEAMCITY_SERVER_IP} \
  -e AGENT_NAME=$AGENT_NAME \
  --name teamcity-agent \
  --restart unless-stopped \
  ${TEAMCITY_IMAGE}

