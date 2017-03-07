# multi-dockerized-wordpress
One host, such wordpress, much isolation. wow.

## WTF is that ?
It's a set of scripts and docker-compose files for building a secured multi-wordpress server.
```
./new_wordpress.sh mywordpressdomain.com
```

## Secure
Each wordpress got its own mariadb database, with randomly-generated password.
If one website is taked-down and the db is compromized, other wordpress instances remains safe.

Let's encrypt powered SSL script ! (wip)

## Simple
What can I do with that ?
* One sftp account for the whole server (all wordpress instances)
* One phpmyadmin url for the whole server (all db instances)
* Ui view with linux-dash
* Automatize creation of ssl certs (wip)
* A lot of other things !

## Deployement [WIP]
This repo provide only docker scripts for create wp instances.

### Prerequistes
You need mariadb installed on the host.

### Web servers
(example of configuration with nginx & apache) 

Nginx =(reverse-proxy)=> (apache & nginx-proxy-container)
apache + php => phpmyadmin & linux-dash
nginx-proxy-container => all wp sites

### Core containers
Launch the nginx-proxy and create docker network:
```
./scripts/core_start.sh
```
Create environment variables:
```
export MARIA_PWD mymariadbpassword
export MAIL_CONTACT iwillreceivesitecredentials@example.com
```

### Create wp instance
```
./new_wordpress.sh
```

### Manage sftp permissions
You need to configure sftp in a way that files uploaded got rw permissions for www-data group. What I've done:
* Created user for sftp only and with www-data as primary group

### Misc
Custom proxy configuration for phpmyadmin (timeout during importation of big SQL files)
For nginx:
```
client_max_body_size 100M;
proxy_send_timeout          600;
proxy_read_timeout          600;
```
