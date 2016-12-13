# multi-dockerized-wordpress
One host, such wordpress, much isolation. wow.

## WTF is that ?
It's a set of scripts and docker-compose files for building a secured multi-wordpress server.
```
./new_wordpress.sh mywordpressdomain.com
```

## Secure
Each wordpress got its own mariadb instance, with randomly-generated password.
If one website is taked-down and the db is compromized, other wordpress instances remains safe.

Let's encrypt powered SSL script !

## Simple
* One sftp account for the whole server (all wordpress instances)
* One phpmyadmin url for the whole server (all db instances)
* Ui view incomin'

## Network topology
Graphml incomin'


## Deployement

### Core containers
Like postfix, nginx, phpmyadmin...
```
./scripts/core_start.sh
```

### Manage sftp permissions
You need to configure sftp in a way that files uploaded got rw permissions for www-data group. What I've done:
* Created user for sftp only and with www-data as primary group
* Setted default umask for this user through sftp. At the end of /etc/pam.d/sshd add:
```
# Setting UMASK for all ssh based connections (ssh, sftp, scp)
session    optional     pam_umask.so umask=002
```
