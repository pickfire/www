Setting up this site for free
=============================
In the process of creating this site with an abnormal way (using ddns), most
people had told me to give up and go buy a domain, I refuse. And now, here am
I.

> First they ignore you, then they laugh at you, then they fight you, then you
> win.  -- Mahatma Gandhi

**Warning: Always believe in yourselves and never give up during the process.**

> Patience and diligence, like faith, remove mountains.  -- Willian Penn

HTTP Setup
==========

Build website
-------------
Clone the [website source][src] in `/srv/www/pickfire.tk/`.
Run `make` with the following `config.sh`.

    PROT=http://
    TARG=/srv/http/pickfire.tk
    HOST=pickfire.tk
    #TARG=/srv/http/pickfireywcq2wf2.onion  # build with this as well for tor
    #HOST=pickfireywcq2wf2.onion

Setup httpd
-----------
Install `h2o`.

Base website with virtual host and tor support.

    hosts:
      "pickfire.tk:80": &www
        listen: 80
        paths: &www_paths
          /:
            file.dir: /srv/http/pickfire.tk
            file.send-compressed: ON
            access-log: /var/log/h2o/www.log
          /tor:
            fastcgi.spawn: "exec /srv/tor/check/check.cgi"
            access-log: /var/log/h2o/tor.log
          /status: &default_status
            mruby.handler: |
              acl {
                allow { addr == "192.168.1.100" }
                respond(404, {}, ["not found"])
              }
            status: ON
            access-log: /var/log/h2o/status.log
      "pickfireywcq2wf2.onion:80":
        <<: *www
        paths:
          <<: *www_paths
          /:
            file.dir: /srv/http/pickfireywcq2wf2.onion
            file.send-compressed: ON
      "pickfire.tk:443":
        listen:
          port: 443
          ssl: &default_ssl
            minimum-version: TLSv1.2
            cipher-suite: ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256
            certificate-file: /srv/www/acme.sh/pickfire.tk/fullchain.cer
            key-file: /srv/www/acme.sh/pickfire.tk/pickfire.tk.key
        header.set: "Strict-Transport-Security: max-age=15768000; includeSubDomains"
        paths: *www_paths

Use [acme.sh][acme] as Let's Encrypt client (minimal client for posix shell).

    git clone https://github.com/Neilpang/acme.sh.git
    cd acme.sh
    ./acme.sh --install --home /srv/www/acme.sh

Setup certs:

	. /srv/www/acme.sh/acme.sh.env
	acme.sh --issue -d pickfire.tk -d www.pickfire.tk -w /srv/http/pickfire.tk

For cgit (this took me a while to figure it out):

    "git.pickfire.tk:80": &git
      listen: 80
      paths: &git_paths
        /cgit.css:
          file.file: /srv/git/cgit.css
          file.send-compressed: ON
        /favicon.ico: &default_ico
          file.file: /srv/www/pickfire.tk/favicon.ico
          file.send-compressed: ON
        /:
          fastcgi.spawn: "exec $H2O_ROOT/share/h2o/fastcgi-cgi"
          setenv:
            SCRIPT_FILENAME: /srv/git/cgit.cgi
          compress: ON
          access-log: /var/log/h2o/git.log
        /status: *default_status

For files with auto index:

    "dl.pickfire.tk:80": &dl
      listen: 80
      paths: &dl_paths
        /:
          file.dir: "/srv/ftp"
          file.dirlisting: ON
          compress: ON
          access-log: /var/log/h2o/dl.log
        /favicon.ico: *default_ico
        /status: *default_status

[acme]: http://acme.sh

Setup cgit
----------
Install `cgit`, `fcgiwrap` (now used the one in `h2o`).

Setup git daemon
----------------
Install `git-daemon`.

- Run with `--base-path /srv/git` for git directory.
- Run without `--export-all` to prevent auto-export.

Bare repository
---------------
Do `git clone --bare` for the files.

Owner of git repository is appended to `repo/config`.

    [gitweb]
    	owner = Ivan Tham <pickfire@riseup.net>

Project description in `repo/description`.

DNS setup
=========
Aha, free sites

DOT.TK
------
Get my domain pickfire.tk here

NSD DNS server
--------------
I use nsd authoritative-only dns server in conjunction with dnsmasq.
(Not applicable anymore after switching to cloudflare DNS)

<https://www.digitalocean.com/community/tutorials/how-to-use-nsd-an-authoritative-only-dns-server-on-ubuntu-14-04>

Zone file
---------
In `/etc/nsd/pickfire.tk.zone`.

    $ORIGIN pickfire.tk.
    $TTL 300
    
    ; Start of authority (required)
    @       IN      SOA     pickfire.tk.    noone.pickfire.tk. (
                    2016071701      ; Serial
                    300             ; refresh
                    300             ; retry
                    2W              ; expire
                    1D              ; minimum TTL
                    )
    
    ; Name servers
            IN      NS      ali.ns.cloudflare.com
            IN      NS      theo.ns.cloudflare.com
            IN      NS      ns101.cloudns.net.
            IN      NS      ns102.cloudns.net.
    ;       IN      NS      pickfire.epac.to.
    ;       IN      NS      vince.ddns.info.
    ;       IN      NS      pickfire.dynamic-dns.net.
    ;       IN      NS      pickfire.longmusic.com.
    ;       IN      NS      pickfire.compress.to.
    
    ; A records for name servers
    ;vince.ddns.info.       IN      A       210.195.229.205
    ;pickfire.epac.to.      IN      A       210.195.229.205
    
    ; Resource records
    @       IN      A       210.195.229.205
    www     IN      A       210.195.229.205

Backup DNS
----------
Cloudflare DNS-only with the following dns update script.

    curl -s -X GET "https://api.cloudflare.com/client/v4/zones/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/dns_records" \
      -H "X-Auth-Email: pickfire@riseup.net" \
      -H "X-Auth-Key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" \
      -H "Content-Type: application/json" \
      | jq -r ".result[] | select(.type == \"A\") | @sh \"curl -s -w '\n' -X PUT https://api.cloudflare.com/client/v4/zones/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/dns_records/\(.id) -H 'X-Auth-Email: pickfire@riseup.net' -H 'X-Auth-Key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' -H 'Content-Type: application/json' -d '\" + ({type: \"A\", name: .name, content: \"$IP\"} | tostring) + \"'\"" \
      | xargs -0 sh -c

Iptables
--------

Search Arch wiki for the following.

- sshguard
- filter incoming
- drop ping request

### Open DNS

Using this setup, people could just spoof udp request and use the server as a
bot to ddos other servers. To solve this fast, I did this myself without my
father's help (slow), so I did add an iptables rule. external:53 -> internal:5353

    iptables -t nat -A PREROUTING -s 192.168.1.0/24 -p udp -m udp --dport 53 -j DNAT --to 127.0.0.1:5353

Dynamic DNS service (old setup)
===============================
I personally used changeip.com after signing up for a few dns service.

Port forwarding
---------------
I am not sure about this. Go ask my father.

Tor Hidden Service
==================
Why? Firewall isn't Tor-proof, prevent censorship and support a better privacy.

Setup Tor hidden service
------------------------
Edit `/etc/tor/torrc`, private keys in `/srv/tor` for Alpine *data-mode*.

    DNSPort 9053

    HiddenServiceDir /srv/tor/web/
    HiddenServicePort 80 127.0.0.1:80
    HiddenServicePort 9418 127.0.0.1:9418

