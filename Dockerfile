FROM jruby:9

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common netcat && \
    curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
    $(lsb_release -cs) \
    stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-compose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN jruby -S gem install \
    cucumber:3.1.0 \  
    turnip:3.1.0 \
    turnip_formatter:0.7.0

# cucumber:2.4.0 \

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64.deb
RUN dpkg -i dumb-init_*.deb && rm dumb-init_*.deb

## default .rpsec configs
COPY ./.rspec /root/.rspec

# helpers
COPY helpers /opt/helpers

COPY bin/start.sh /opt/bin/start.sh

WORKDIR /opt/project

ENTRYPOINT ["/usr/bin/dumb-init", "/opt/bin/start.sh"]
