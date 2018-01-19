# How to setup Postfix on Ubuntu 17.10

Use the following command below to reconfigure an existing install.

```
dpkg-reconfigure postfix
```

## A Mail Relay with Postfix

Install Postfix and Mail utilities:

```
apt-get install postfix
apt-get install mailutils
```

During the installation select `Satellite system` and configure Postfix
to use Mailgun's SMTP server for relayed mail `smtp.mailgun.org`

Create and edit a new credentials file:

```
sudo vi /etc/postfix/sasl_passwd
```

And add the following line:

```
smtp.mailgun.org your_mailgun_smtp_user@your_subdomain_for_mailgun:your_mailgun_smtp_password
```

Next, protect the file by restricting read and write permissions to root and and use the postmap command to update Postfix's lookup tables to use this new file:

```
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd
```

Next, enhance the mail relay's security by preventing anonymous logins
and specifying the credentials file to provide secure logins to Mailgun.

Edit the Postfix configuration file:

```
sudo vi /etc/postfix/main.cf
```

And add the following at the bottom of the file:

```
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_sasl_tls_security_options = noanonymous
smtp_sasl_mechanism_filter = AUTH LOGIN
```

### Domain Mapping

Since we're using Mailgun for our SMTP server instead of Postfix, your server's hostname does not need to match the FQDN you are using for your email. This is very common. For example, If your server is a database server or a monitoring server, it may not have a FQDN at all. We can set up a mapping table, which substitutes one e-mail address for another.

In this case, we are going to map your Linux user email account to any username you wish at your MailGun domain.

```
sudo vi /etc/postfix/generic
```

And add the following line to the file:

```
root@your_hostname sender@your_domain_for_mailgun
```

You can replace sender with whatever name you wish, such as no-reply. The only part that really matters is your_domain_for_mailgun, which should be your Mailgun domain you defined earlier.

You can specify multiple users by creating more lines like this one.

Now add this mapping to the Postfix lookup tables by using the postmap command:

```
sudo postmap /etc/postfix/generic
```

Then edit your Postfix configuration file to add the mapping file:

```
sudo vi /etc/postfix/main.cf
```

Add this line to the end of the file:

```
smtp_generic_maps = hash:/etc/postfix/generic
```

Lets also make Postfix send local emails with your preferred email address as the "sender" header.

```
sudo vi /etc/postfix/sender_canonical
```

And add the following lines to the file:

```
www-data     sender@your_domain_for_mailgun
root         sender@your_domain_for_mailgun
```

Then map the new file to Postfix.

```
postmap hash:/etc/postfix/sender_canonical
```

Edit the Postfix configuration file:

```
sudo vi /etc/postfix/main.cf
```

And add the following at the bottom of the file:

```
sender_canonical_maps=hash:/etc/postfix/sender_canonical
```

Now restart the Postfix service:

```
sudo /etc/init.d/postfix restart
```

## Testing Your Mail Relay

Use mailutils to compose and send a message to your personal email account from your current user on the server.

```
mail -s "Test mail" your_email_address <<< "A test message using Mailgun"
```
