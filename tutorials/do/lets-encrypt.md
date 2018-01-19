# How to setup Let's Encrypt with Nginx on Ubuntu 17.04

Let's Encrypt is a Certificate Authority (CA) that provides an easy way to obtain and install free TLS/SSL certificates, thereby enabling encrypted HTTPS on web servers. It simplifies the process by providing a software client, Certbot, that attempts to automate most (if not all) of the required steps. Currently, the entire process of obtaining and installing a certificate is fully automated on both Apache and Nginx.

## Step 1 — Installing Certbot

The first step to using Let's Encrypt to obtain an SSL certificate is to install the Certbot software on your server.

Certbot is in very active development, so the Certbot packages provided by Ubuntu tend to be outdated. However, the Certbot developers maintain a Ubuntu software repository with up-to-date versions, so we'll use that repository instead.

First, add the repository:

```
sudo add-apt-repository ppa:certbot/certbot
```

Then update the repository's package information:

```
sudo apt-get update
```

Finally install Certbot's Nginx package:

```
sudo apt-get install python-certbot-nginx
```

## Step 2 — Confirming Nginx's Configuration

Certbot needs to be able to find the correct server block in your Nginx configuration for it to be able to automatically configure SSL. Specifically, it does this by looking for a server_name directive that matches the domain you request a certificate for.

If you followed the prerequisite tutorial on Nginx server blocks, you should have a server block for your domain at `/etc/nginx/sites-available/example.com` with the server_name directive already set appropriately.

```
server_name example.com www.example.com;
```

## Step 3 — Allowing HTTPS Through the Firewall

You can see the current setting by typing:

```
ufw status
```

It will probably look like this, meaning that only HTTP traffic is allowed to the web server:
```
Status: active

To                         Action      From
--                         ------      ----
OpenSSH                    ALLOW       Anywhere
Nginx HTTP                 ALLOW       Anywhere
OpenSSH (v6)               ALLOW       Anywhere (v6)
Nginx HTTP (v6)            ALLOW       Anywhere (v6)
```

To additionally let in HTTPS traffic, we can allow the Nginx Full profile and then delete the redundant Nginx HTTP profile allowance:

```
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'
```

## Step 4 — Obtaining an SSL Certificate

Certbot provides a variety of ways to obtain SSL certificates, through various plugins. The Nginx plugin will take care of reconfiguring Nginx and reloading the config whenever necessary:

```
sudo certbot --nginx -d example.com -d www.example.com
```

If that's successful, certbot will ask how you'd like to configure your HTTPS settings. Select your choice then hit ENTER. The configuration will be updated, and Nginx will reload to pick up the new settings. certbot will wrap up with a message telling you the process was successful and where your certificates are stored.

## Step 5 — Updating Diffie-Hellman Parameters

The Diffie-Hellman parameters affect the security of the initial key exchange between our server and its users. You can improve them by creating a new dhparam.pem file and adding it to your Nginx configuration.

Create the file using openssl:

```
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

This can take up to a few minutes. When it's done, open up a new configuration file in Nginx’s conf.d directory.

```
sudo nano /etc/nginx/conf.d/dhparam.conf
```

Paste in the following ssl_dhparam directive /etc/nginx/conf.d/dhparam.conf

```
ssl_dhparam /etc/ssl/certs/dhparam.pem;
```

Save the file and quit your editor, then verify the configuration.

```
sudo nginx -t
```

Once there are no errors, reload Nginx.

```
sudo systemctl reload nginx
```

## Step 6 — Setting Up Auto Renewal

Let's Encrypt's certificates are only valid for ninety days. This is to encourage users to automate their certificate renewal process.

To run the renewal check daily, we will use cron, a standard system service for running periodic jobs.

```
sudo crontab -e
```

Your text editor will open the default crontab which is a text file with some help text in it. Paste in the following line at the end of the file, then save and close it:

```
. . .
15 3 * * * /usr/bin/certbot renew --quiet
```

The 15 3 * * * part of this line means "run the following command at 3:15 am, every day". You may choose any time.

The renew command for Certbot will check all certificates installed on the system and update any that are set to expire in less than thirty days. --quiet tells Certbot not to output information or wait for user input.

cron will now run this command daily. All installed certificates will be automatically renewed and reloaded when they have thirty days or less before they expire.
