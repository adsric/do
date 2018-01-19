# Miscellaneous Nginx Rules

Helpful specific rules for Nginx.

## Redirects

```
# Pass a directory with variable to a subdomain
location ^~ /directory/ {
	rewrite ^/directory/(.*) http://subdomain.example.com/$1 permanent;
}
```

```
# A temporary redirect of an old location to new 302
rewrite ^/oldlocation$ http://example.com/newlocation redirect;
```

```
# A permanet redirect of an old location to new 301
rewrite ^/oldlocation$ http://www.newdomain.com/newlocation permanent;
```

## Wordpress Rules

* Added security in the uploads directory
* Multisite subdirectory rules

```
# Deny access to any files with a .php extension in the uploads directory
# Works in sub-directory installs and also in multisite network
# Keep logging the requests to parse later (or to pass to firewall utilities such as fail2ban)
location ~* /(?:uploads|files)/.*\.php$ {
	deny all;
}
```

```
# Multisite subdirectory rewrite rules
if (!-e $request_filename) {
	rewrite /wp-admin$ $scheme://$host$uri/ permanent;
	rewrite ^/[_0-9a-zA-Z-]+(/wp-.*) /app$1 last;
	rewrite ^/[_0-9a-zA-Z-]+(/.*\.php)$ /app$1 last;
}
```

For more rules [see](https://codex.wordpress.org/Nginx)
