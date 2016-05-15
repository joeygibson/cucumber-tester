#!/usr/bin/env bash

set -e

echo "Running Cucumber Tests from $(pwd)..."

if [ $# == 0 ]; then
    /usr/local/bundle/bin/cucumber ./features/
else
    /usr/local/bundle/bin/cucumber "$@"
fi
