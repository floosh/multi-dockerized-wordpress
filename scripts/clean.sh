#!/bin/bash

# stop all docker containers
docker stop $(docker ps -a -q)

# rm all docker containers
docker rm $(docker ps -a -q)

rm -rf /var/docker/compose/*
rm -rf /var/docker/websites/*

docker volume rm $(docker volume ls -qf dangling=true)
