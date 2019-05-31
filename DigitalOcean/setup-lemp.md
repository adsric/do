# How to setup your LEMP server on Ubuntu 18.04 LTS

The goal of this tutorial is to provide the steps needed for the right environment configuration to host a PHP application. To achieve this, you need to install and configure:

* a web server: Nginx (a virtual host);
* a database server: MariaDB;
* a PHP7 interpreter.

The following steps are based on an Ubuntu 18.04 LTS installation on the Cloud Hosting Provider
DigitalOcean.


## Step One: login via root and user creation

During the Droplet creation step on DigitalOcean Control panel, if you didn’t select “SSH Key” option, you should have received an email with the credentials and an IP address like this:

```
Droplet Name: ubuntu-lemp
IP Address: your_server_ip
Username: root
Password: your_password
```

Access to your new droplet:

```
ssh root@your_server_ip
```

For the installation of the Web Server, Database Server and PHP you can use root privileges, but for deploying the application you will need “normal” user privileges.
To add a user named example you need:

```
adduser example
```

and then you need to add the user to sudo group to allow it to execute commands with special privileges. To enable the new user example for using sudo command:

```
usermod -aG sudo example
```

## Step two: Update the operating system and activate the firewall

First of all you need to keep your system updated:

```
apt-get update
apt-get upgrade
```

Then, install Nginx:

```
apt-get install nginx
```

Now you need to close some ports and to activate the firewall.
Open only HTTP and SSH ports:

```
ufw allow 'Nginx HTTP'
ufw allow 'OpenSSH'
```

For SSL

```
ufw allow 'Nginx Full'
ufw delete allow 'Nginx HTTP'
```

Activate the firewall:

```
ufw enable
```

And finally check the status:

```
ufw status
```

The output should be something like this:

```
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere
Nginx HTTP                 ALLOW       Anywhere
OpenSSH (v6)               ALLOW       Anywhere (v6)
Nginx HTTP (v6)            ALLOW       Anywhere (v6)
```

## Step Three: setup a Virtual Host in Nginx

Create the directory where to place your PHP files:

```
mkdir -p /var/www/example.com/public
```

Install the PHP interpreter:

```
apt-get install php-fpm php-mysql
```

Install the PHP extensions:

```
apt-get install php7.2-gd php7.2-curl php7.2-json php7.2-xml
```

Give the right ownership to the directory (example is the user owner, www-data is the group owner) and permission (750) in recursive way:

```
chown -R example:www-data /var/www/example.com/*
chmod -R 750 /var/www/example.com/
```

Now you need to create the Nginx configuration file for the virtual host:

```
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
```

An example of a Nginx Server Block configuration: [example.com](/Nginx/_example.md)

Enable the configuration and create a symbolic link for the new configuration file from sites-enabled directory to sites-available:

```
ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
```

Add the row:

```
server_names_hash_bucket_size 64;
```
to the /etc/nginx/nginx.conf file in the http section.

If you want to deny the request via http with numeric IP address, remove the symbolic link for the deactivation of the the main/default virtual host:

```
rm /etc/nginx/sites-enabled/default
```

Test your Nginx configuration:

```
nginx -t
```

Restart the Nginx server:

```
service nginx restart
```

## Step Four: install the Database (MariaDB)

Ubuntu 18.04 doesn't package the latest MariaDB so follow the steps to get
the latest stable version.

To add MariaDB repository to Ubuntu, run the commands below to
install the repository key to your system.

```
sudo apt-get install software-properties-common
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
```

After adding the repository key above, continue below to add MariaDB repository.

Before adding the repository below, please visit the download page and get the latest (current) version number. At the time of this post, the latest stable version was at 10.3.

When you find the current version number, replace the highlighted number in the command with it, then run the command:

```
sudo add-apt-repository 'deb [arch=amd64] http://mirror.zol.co.zw/mariadb/repo/10.3/ubuntu bionic main'
```

Install the latest database server with the following commands:

```
apt-get update
apt-get install mariadb-server
```
execute the script to complete the configuration:

```
mysql_secure_installation
```
during the execution of this script, it will ask you to type the root database password.

When the execution is completed, try to access to your database server:

```
mysql -u root -p
```
and input the new password to access to the database administration console.

In the database administration console:

* create the database db_example
* create the user to access the database (dbuserexample) with the password db_password
* grant the right privileges to the new user (including remote access)

```
create database db_example;
CREATE USER 'dbuserexample'@'localhost' IDENTIFIED BY 'db_password';
GRANT ALL PRIVILEGES ON * . * TO 'dbuserexample'@'localhost';
FLUSH PRIVILEGES;
```

In the database administration console:

* grant root the right privileges to remote access

```
GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost' IDENTIFIED BY 'db_password' WITH GRANT OPTION;
```

* set a new password for a username

```
SET PASSWORD FOR 'dbuserexample'@'localhost' = PASSWORD('NewPass');
```

## Step Five: test your installation and configuration

Open your Web Browser and go to your URL
