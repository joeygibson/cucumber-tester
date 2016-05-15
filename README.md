# cucumber-turnip-tester

Provides a base Docker Image for testing using Turnip and Cucumber

## Building

    ./script/build

Will create a docker image called `cucumber-turnip-tester`

## Using with Docker projects

To use this image in your repo, you should add something like the following `docker-compose` service:

    app:
        image: restygo
        volumes:
        - .:/opt/project/
    bbtest:
        image: cucumber-turnip-tester:latest
        links:
            - app
        volumes:
            - .:/opt/project/
            - /var/run/docker.sock:/var/run/docker.sock
        working_dir: /opt/project
        command: ["-r", "/opt/project/bbtest/features", "/opt/project/bbtest/features"]

## Running

    docker-compose run --rm bbtest
    docker-compose kill
