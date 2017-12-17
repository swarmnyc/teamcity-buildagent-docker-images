FROM jetbrains/teamcity-agent

ENV DOCKER_COMPOSE_VERSION="1.13.0" \
    NVM_VERSION="v0.33.8" \
    NODE_VERSION="v4" \
    KURENTO_REPO="xenial-dev"

# Install util tools.
RUN apt-get -y update \
    && apt-get install -y wget curl

# Install kurento development environment.
RUN set -x \
    && echo "deb http://ubuntu.kurento.org ${KURENTO_REPO} kms6" | tee /etc/apt/sources.list.d/kurento.list \
    && wget http://ubuntu.kurento.org/kurento.gpg.key -O - | apt-key add - \
    && apt-get update \
    && apt-get install -y kurento-media-server-6.0-dev

# Install nvm, node & typescript.
RUN set +x \
    && curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm --version && nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION} \
    && node -v && npm -v \
    && npm install -g bower \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose

 