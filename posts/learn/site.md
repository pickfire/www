Setting up this site for free
=============================
In the process of creating this site with an abnormal way (using ddns), most
people had told me to give up and go buy a domain, I refuse. And now, here am
I.

> First they ignore you, then they laugh at you, then they fight you, then you
> win.  -- Mahatma Gandhi

**Warning: Always believe in yourselves and never give up during the process.**

> Patience and diligence, like faith, remove mountains.  -- Willian Penn

Site generator
==============
Get the source, run `make`, the generated files will be in the *html* directory.

Setup httpd
-----------
Install `nginx`.

Setup cgit
----------
Install `cgit`, `fcgiwrap`.

Bare repository
---------------
Do `git clone --bare`.

Virtual hosting
---------------
http://nginx.org/en/docs/http/request_processing.html

Dynamic DNS service
===================
I personally used changeip.com after signing up for a few dns service.

Port forwarding
---------------
I am not sure about this currently. Go ask my father.

Tor Hidden Service
==================
Why? Firewall isn't Tor-proof, prevent censorship and support a better privacy.

Setup Tor hidden service
------------------------
Edit `/etc/tor/torrc`

Directing subdomain to Tor
--------------------------
https://www.nginx.com/blog/creating-nginx-rewrite-rules/
