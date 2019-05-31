# Virtual Host Configuration: example.com

```
# www to non-www redirect
# Choose between www and non-www, listen on the *wrong* one and redirect to
# the right one -- http://wiki.nginx.org/Pitfalls#Server_Name
server {
	# don't forget to tell on which port this server listens
	listen 80;
	listen [::]:80;

	# listen on the www host
	server_name www.example.com;

	# and redirect to the non-www host (declared below)
	return 301 $scheme://example.com$request_uri;
}

server {
	# don't forget to tell on which port this server listens
	listen 80 default_server;
	listen [::]:80 default_server;

	# The host name to respond to
	server_name example.com;

	# Path for static files
	root /var/www/example.com/public;

	# Specify a charset
	charset utf-8;

	index index.php index.html index.htm index.nginx-debian.html;

	location / {
		try_files $uri $uri/ /index.php$is_args$args;
	}

	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;

		# This is a robust solution for path info security issue
		# works with "cgi.fix_pathinfo = 1" in /etc/php.ini (default)
		if (!-f $document_root$fastcgi_script_name) {
			return 404;
		}
	}

	location ~ /\.ht {
		deny all;
	}
}
```
