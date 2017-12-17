#!/bin/bash

EC2_IPV4_LOCAL=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
TEAMCITY_VERSION=latest
TEAMCITY_SERVER_IP=34.224.141.66

# Launch TeamCity Server
sudo docker run -d \
  -v /mnt/data/teamcity:/data/teamcity_server/datadir \
  -v /mnt/data/logs/teamcity:/opt/teamcity/logs \
  -v /mnt/data/temp/teamcity:/opt/teamcity/temp \
  -p 80:8111 \
  --name teamcity-server \
  --restart unless-stopped \
  jetbrains/teamcity-server

# Launch TeamCity Build Agent
sudo docker run -d \
  -v /mnt/data/teamcity:/data/teamcity_agent/conf \
  -v /mnt/data/temp/teamcity:/opt/teamcity/temp \
  -e SERVER_URL=${TEAMCITY_SERVER_IP} \
  -e AGENT_NAME=Default \
  --name teamcity-agentc \
  --privileged -e DOCKER_IN_DOCKER=start \
  --restart unless-stopped \
  swarmnyc/teamcity-agent:${TEAMCITY_VERSION}

