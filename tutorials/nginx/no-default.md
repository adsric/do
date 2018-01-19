# Drop requests to unknown virtual hosts

The content of the (no-default) Nginx configuration file is:

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