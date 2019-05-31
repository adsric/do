## Password protect a directory in Nginx

**Step one** - Create the Password File using the OpenSSL utilities.

```
sudo sh -c "echo -n 'username:' >> /var/www/example.com/.htpasswd"
sudo sh -c "echo "password" | openssl passwd -apr1 -stdin >> /var/www/example.com/.htpasswd"
```

**Step two** - Add Nginx Virtual Host Configuration for Password Authentication.

```
vi /etc/nginx/site-available/example.com

location / {
	auth_basic "Restricted Content";
	auth_basic_user_file /var/www/example.com/.htpasswd;
}
```
