#!/bin/bash
# arguments : database name (= user login)
# returns: user password

db_name=$1
user_name=$1
user_pwd=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo ''`

mysql -uroot -p$MARIA_PWD -e "CREATE DATABASE ${db_name} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -uroot -p$MARIA_PWD -e "CREATE USER ${user_name}@localhost IDENTIFIED BY '${user_pwd}';"
mysql -uroot -p$MARIA_PWD -e "GRANT ALL PRIVILEGES ON ${db_name}.* TO '${user_name}'@'localhost';"
mysql -uroot -p$MARIA_PWD -e "FLUSH PRIVILEGES;"

echo ${user_pwd}

