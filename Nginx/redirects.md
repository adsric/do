# Redirects for Nginx

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
