# cucumber-tester

[![Build Status](https://travis-ci.org/joeygibson/cucumber-tester.svg?branch=master)](https://travis-ci.org/joeygibson/cucumber-tester)

Provides a base Docker Image for testing using [Cucumber](https://cucumber.io).

A great deal of this was shamelessly lifted from work that [Mike Luu](https://github.com/munkyboy),
[Paul Cichonski](https://github.com/paulcichonski), and, to a degree, I, did for our employer.

## Versions

* Cucumber 3.1.0
* Turnip 3.1.0

## Building

    ./script/build

Will create a docker image called `cucumber-tester`

## Using with Docker projects

To use this image in your repo, you should add something like the following `docker-compose` service:

    app:
        image: restygo
        volumes:
        - .:/opt/project/
    bbtest:
        image: cucumber-tester:latest
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

## Note

* Turnip is still installed, but the main focus of this image is cucumber.

