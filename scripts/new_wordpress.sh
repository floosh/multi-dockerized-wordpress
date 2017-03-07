#!/bin/bash
# This must be called with two parameters, as follows:

read -e -p "Website URL ? " URL
read -e -p "Database name ? " -i "${URL//./}" DBNAME

# Proper number of arguments are there, carry on.

DOCKERDIR=/docker/compose
WEBDIR=/docker/websites
DBPWD=`./mysql.sh ${DBNAME}`

# Step 1: much mkdir
mkdir -p  $DOCKERDIR/$URL
mkdir -p $WEBDIR/$URL
chown www-data:www-data $WEBDIR/$URL
chmod 775 $WEBDIR/$URL

# Step 2: such templating
sed -e "s@%WEBDIR%@$WEBDIR@g" -e "s/%URL%/$URL/g" -e "s/%DBPWD%/$DBPWD/g" -e "s/%DBNAME%/$DBNAME/g" -e "s/%HOSTNAME%/$HOSTNAME/g" ../compose/wordpress.yml > $DOCKERDIR/$URL/docker-compose.yml

# Step 3: docker-compose, wow !
docker-compose -f $DOCKERDIR/$URL/docker-compose.yml up -d

# Step 4: send mail, amazing
OUT=$(sed -e "s/%URL%/$URL/g" -e "s/%DBPWD%/$DBPWD/g" -e "s/%DBNAME%/$DBNAME/g" -e "s/%HOSTNAME%/$HOSTNAME/g" mail.template)

if [ -z '$2' ]; then
echo "$OUT" | mail -s "A new website is aviable !" "$MAIL_CONTACT"
fi

echo "$OUT"
