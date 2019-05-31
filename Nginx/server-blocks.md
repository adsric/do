# Nginx Server Block

`/etc/nginx/sites-avaliable/`

`/etc/nginx/sites-enabled/`

## Example.com

A virtual host is an Apache term, however, is commonly used by Nginx users as well. The proper term for Nginx is “server block”. Both of these words have the same meaning which is basically the feature of being able to host multiple websites on a single server. This is extremely useful given that you own multiple sites and don’t want to go through the lengthy (and expensive) process of setting up a new web server for each site.

**Step one** - Configuring Your Nginx Virtual Hosts.

Site folders need to be configured with Nginx virtual host or server blocks for “example.com”. Virtual host config files are typically located in the /etc/nginx/sites-available directory. You may also notice that your server has a /etc/nginx/sites-enabled folder, which is where file shortcuts (aka symbolic links) are placed. You can use the sites-enabled folder to easily enable or disable a virtual host by creating or removing symbolic links.

`
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/example.com
`

An example of said configuration: [example.com](_example.md)

* Modify server_name example.com; as necessary
* Modify root /var/www/example.com/public; as necessary

**Step two** - Configuration with SSL.

- Modify listen 80;

```
listen 443 ssl;
```

- Create and reference SSL certificates

```
ssl_certificate      /etc/ssl/certs/cert.pem;
ssl_certificate_key  /etc/ssl/private/key.pem;
```

- Listen on port 80 and redirect all requests to use https.

```
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;
    return 302 https://$server_name$request_uri;
}
```

## Additional

### Drop requests to Unknown Virtual Hosts

`vim /etc/nginx/sites-available/no-default`

```
# Drop requests for unknown hosts
#
# If no default server is defined, nginx will use the first found server.
# To prevent host header attacks, or other potential problems when an unknown
# servername is used in a request, it's recommended to drop the request
# returning 444 "no response".

server {
	listen [::]:80 default_server deferred;
	return 444;
}
```

### Configure a Virtual Host as CDN

`vim /etc/nginx/sites-available/cdn.example.com`

And copy the example of said configuration: [cdn.example.com](_cdn.md)
