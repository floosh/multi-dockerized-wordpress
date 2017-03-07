#!/bin/sh

# Create local network for databases
#docker network create local_db
docker network create local_web

# Start core containers
docker-compose -f ../compose/proxy.yml up -d
