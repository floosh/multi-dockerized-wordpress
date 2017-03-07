#!/bin/bash

# stop all docker containers
docker stop $(docker ps -a -q)

# rm all docker containers
docker rm $(docker ps -a -q)

rm -rf /docker/compose/*
rm -rf /docker/websites/*

docker volume rm $(docker volume ls -qf dangling=true)
