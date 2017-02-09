FROM jruby:9

RUN apt-get update && \
    apt-get install -y netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN jruby -S gem install \
    cucumber:2.4.0 \
    turnip:2.1.1 \
    turnip_formatter:0.5.0

ENV DOCKER_VERSION 1.13.0
RUN curl -so /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION
RUN chmod a+x /usr/bin/docker

ENV DOCKER_COMPOSE_VERSION=1.11.0
RUN curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
RUN chmod a+x /usr/local/bin/docker-compose

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64.deb
RUN dpkg -i dumb-init_*.deb

## default .rpsec configs
COPY ./.rspec /root/.rspec

# helpers
COPY helpers /opt/helpers

COPY bin/start.sh /opt/bin/start.sh

WORKDIR /opt/project

ENTRYPOINT ["/usr/bin/dumb-init", "/opt/bin/start.sh"]
