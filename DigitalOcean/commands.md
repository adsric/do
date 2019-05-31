# Commands for Ubuntu 18.04 LTS

The following commands will require SSH access to your droplet and that
the droplet is running the OS Ubuntu.

**Get started**

```
ssh root@your_server_ip
```

## Permissions

```
sudo chown -R www-data:www-data /var/www/*
sudo chmod -R 750 /var/www
sudo chgrp -R www-data /var/www
sudo chmod -R g+w /var/www
```

To change all the directories to 755 (drwxr-xr-x):
```
find /opt/lampp/htdocs -type d -exec chmod 755 {} \;
```

To change all the files to 644 (-rw-r--r--):
```
find /opt/lampp/htdocs -type f -exec chmod 644 {} \;
```
