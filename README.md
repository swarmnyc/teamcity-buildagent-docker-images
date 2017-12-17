
![teamcity_status][tc_status_logo]

[tc_status_logo]: http://34.224.141.66/app/rest/builds/buildType:BuildAgentDockerImages_Build/statusIcon "Powered by TeamCity"

# Customized TeamCity Build Agent docker images
Check [the official site](https://github.com/JetBrains/teamcity-docker-agent) for more info.

## How to Build and Push Images
* [swarmnyc/teamcity-agent](ubuntu/typescript/build.sh)
    * docker-compose v1.13.0
    * nvm v0.33.8
    * Node v8
    * typescript
    * Chrome (for test)
* [swarmnyc/teamcity-agent-kurento](ubuntu/kurento/build.sh)
    * docker-compose v1.13.0
    * nvm v0.33.8
    * Node v4
    * Kurento development environment v6.6

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
See [ubuntu/launchTeamCityServer.sh](ubuntu/launchTeamCityServer.sh)

## Test Drive
[Swarm TeamCity](http://34.224.141.66)