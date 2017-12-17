
![teamcity_status][tc_status_logo]

[tc_status_logo]: http://34.224.141.66/app/rest/builds/buildType:BuildAgentDockerImages_Build/statusIcon "Powered by TeamCity"

# Customised TeamCity Build Agent docker images
Check [the official site](https://github.com/JetBrains/teamcity-docker-agent) for more info.

### For build-agent image: swarmnyc/teamcity-agent
```
cd ./ubuntu/typescript/
```
## How to Build and Push This Image
```
docker build -t swarmnyc/teamcity-agent:latest .
docker push swarmnyc/teamcity-agent:latest

# Tag a specified version for the image.
IMAGE_VERSION=1.0.0
docker tag swarmnyc/teamcity-agent:latest swarmnyc/teamcity-agent:${IMAGE_VERSION}
docker push swarmnyc/teamcity-agent:${IMAGE_VERSION}
```

## How to Use This Image
### Run in command line.
```
TEAMCITY_SERVER_IP=34.224.141.66
docker run -d \
    -e SERVER_URL=$TEAMCITY_SERVER_IP \
    -e AGENT_NAME=Default \
    --privileged -e DOCKER_IN_DOCKER=start \
    --name teamcity-agent \
    swarmnyc/teamcity-agent:latest
```

### Create a restarted docker container.
See [ubuntu/launchTeamCityServer.sh](blob/master/ubuntu/launchTeamCityServer.sh)