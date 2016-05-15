FROM jruby:9.0.5.0

RUN apt-get update && \
    apt-get install -y netcat && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN jruby -S gem install \
    cucumber:2.3.2 \
    turnip:2.0.2 \
    turnip_formatter:0.4.0

ENV DOCKER_VERSION 1.11.1
RUN curl -so /usr/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION
RUN chmod a+x /usr/bin/docker

ENV DOCKER_COMPOSE_VERSION=1.7.1
RUN curl -Lo /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-Linux-x86_64
RUN chmod a+x /usr/local/bin/docker-compose

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64.deb
RUN dpkg -i dumb-init_*.deb

## default .rpsec configs
COPY ./.rspec /root/.rspec

# helpers
COPY helpers /opt/helpers

COPY bin/start.sh /opt/bin/start.sh

WORKDIR /opt/project

ENTRYPOINT ["/usr/bin/dumb-init", "/opt/bin/start.sh"]
