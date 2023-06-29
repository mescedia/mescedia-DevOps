#!/bin/bash

version=0.1

cat Dockerfile | docker build --tag mescedia-server:$version -
docker network create --subnet=192.168.12.0/24 mescedia-network
sid=$(docker run -d --net mescedia-network --ip 192.168.12.12 -it mescedia-server:$version)
docker exec $sid /etc/init.d/ssh start



