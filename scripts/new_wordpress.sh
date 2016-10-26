#!/bin/bash
# This must be called with two parameters, as follows:

if [ $# -eq 0 ]
then
    echo "Usage: URL [MAIL]"
    exit 1
fi

# Proper number of arguments are there, carry on.
URL=$1
DOCKER_DIR=/var/docker/compose
WEB_DIR=/var/docker/websites
DBPASS=`tr -dc A-Za-z0-9_ < /dev/urandom | head -c 20 | xargs`
HOSTNAME=`hostname`

# Step 1: much mkdir
mkdir -p  $DOCKER_DIR/$URL
mkdir -p $WEB_DIR/$URL

# Step 2: such templating
sed -e "s/%URL%/$URL/g" -e "s/%DBPWD%/$DBPASS/" ../compose/wordpress-compose.yml > $DOCKER_DIR/$URL/docker-compose.yml

# Step 3: docker-compose, wow !
docker-compose -f $DOCKER_DIR/$URL/docker-compose.yml up -d

# Step 4: send mail, amazing
OUT=$(sed -e "s/%URL%/$URL/g" -e "s/%DBPWD%/$DBPASS/" -e "s/%HOSTNAME%/$HOSTNAME/" mail.template)

if [ -z '$2' ]; then
echo "$OUT" | mail -s "A new website is aviable !" "$2"
fi

echo "$OUT"
