#!/bin/sh
export HOSTNAME=`hostname`
for f in ../compose/*core.yml
do
  echo "$f"
  docker-compose -f "$f" up -d
done
