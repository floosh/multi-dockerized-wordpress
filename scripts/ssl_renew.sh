#!/bin/bash

P1=/etc/letsencrypt/live
P2=/var/docker/certs

docker stop nginx-proxy;

certbot renew --quiet;

for domain in `ls $P1`
do
	cp $P1/$domain/fullchain.pem $P2/$domain.crt;
	cp $P1/$domain/privkey.pem $P2/$domain.key;
done

docker start nginx-proxy;
