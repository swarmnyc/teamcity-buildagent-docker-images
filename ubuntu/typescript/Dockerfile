FROM jetbrains/teamcity-agent

ENV DOCKER_COMPOSE_VERSION="1.13.0" \
    NVM_VERSION="v0.33.8" \
    NODE_VERSION="8.x"

# Install build & util tools.
RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
       wget python python2.7-dev fakeroot ca-certificates tar gzip zip \
       autoconf automake bzip2 file g++ gcc imagemagick libbz2-dev libc6-dev libcurl4-openssl-dev \
       libdb-dev libevent-dev libffi-dev libgeoip-dev libglib2.0-dev libjpeg-dev libkrb5-dev \
       liblzma-dev libmagickcore-dev libmagickwand-dev libmysqlclient-dev libncurses-dev libpng-dev \
       libpq-dev libreadline-dev libsqlite3-dev libssl-dev libtool libwebp-dev libxml2-dev libxslt-dev \
       libyaml-dev make patch xz-utils zlib1g-dev unzip curl

# Install Chrome(HeadlessChrome) for Karma Test
# From: https://gist.github.com/ziadoz/3e8ab7e944d02fe872c3454d17af31a5
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -y update \
    && apt-get -y install google-chrome-stable

# Install nvm, node & typescript.
RUN set +x \
    && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - \
    && apt-get install nodejs -y \
    && npm -v \
    && npm install typescript gulp npm -g \
    && npm -v

# Install docker-compose
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m) > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose

# Instal AWS CLI & ecs-deploy (https://github.com/fabfuel/ecs-deploy)
RUN wget "https://bootstrap.pypa.io/get-pip.py" -O /tmp/get-pip.py \
    && python /tmp/get-pip.py \
    && pip install awscli==1.11.25 \
    && pip install ecs-deploy

# Clearn up
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean
