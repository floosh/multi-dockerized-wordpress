#!/bin/sh

# Create local network for databases
docker network create local_db
docker network create local_web

# Start core containers
export HOSTNAME=`hostname`

for f in ../compose/*core.yml
do
  echo "$f"
  docker-compose -f "$f" up -d
done
