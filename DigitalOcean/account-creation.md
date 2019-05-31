# SFTP Account creation

* Add new user
* Add user to privileges group www-data
* Add user to specific home directory

```
adduser username
usermod -a -G www-data username
usermod -m -d /var/www/example.com username
```

To allow droplet password authentication add `password authentication on`
**Not recommended**

```
vim /etc/ssh/sshd_config
```
