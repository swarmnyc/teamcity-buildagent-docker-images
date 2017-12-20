
![teamcity_status][tc_status_logo]

[tc_status_logo]: http://34.224.141.66/app/rest/builds/buildType:BuildAgentDockerImages_Build/statusIcon "Powered by TeamCity"

# Customized TeamCity Build Agent docker images
Check [the official site](https://github.com/JetBrains/teamcity-docker-agent) for more info.

## How to Build and Push Images
* [swarmnyc/teamcity-agent](ubuntu/typescript/build.sh)
    * docker-compose v1.13.0
    * nvm v0.33.8
    * Node v8
    + gulp@3.9.1
    + npm@5.6.0
    + typescript@2.6.2
    * awscli v1.11.25
    * [ecs-deploy-1.4.3](https://github.com/fabfuel/ecs-deploy)
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
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e SERVER_URL=$TEAMCITY_SERVER_IP \
    -e AGENT_NAME=Default \
    --name teamcity-agent \
    swarmnyc/teamcity-agent:latest
```

### Create a restartable docker container.
* TeamCity Server, see [ubuntu/launchTeamCityServer.sh](ubuntu/launchTeamCityServer.sh)
* TeamCity Build Agent, see [ubuntu/launchTeamCityBuildAgent.sh](ubuntu/launchTeamCityBuildAgent.sh)

## Docker In Docker
Since we need to build a docker image within a Build Agent, which itself is a docker container, we have to deal with the [Docker In Docker](https://github.com/jpetazzo/dind) issue.

There are [two options](https://hub.docker.com/r/jetbrains/teamcity-agent/) to handle it:
* bind-mounting the Docker socket
* privileged way

We pick the first one, according to this article: [Using Docker-in-Docker for your CI or testing environment?](http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)

## Test Drive
[Swarm TeamCity](http://34.224.141.66)

