#!/usr/bin/env bash

# returns the source directory reference relative to the docker daemon for a
# given directory in this container
#
# $1 -> path in this container
docker -H unix:///var/run/docker.sock inspect -f "{{range .Mounts}}{{if eq .Destination \"${1}\"}}{{.Source}}{{end}}{{end}}" $(hostname)
