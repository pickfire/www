Privacy Die Hard!
=================

> Arguing that you don't care about the right to privacy because you have
> nothing to hide is no different than saying you don't care about free speech
> because you have nothing to say.  ── Edward Snowden

Why care about privacy? Think, why do we have door locks for bathroom.

Isn't the web secure? No, someone might be spying on you, you will never know
who is the man in the middle, he might be a hacker, a robber or even a (what
rhymes with hacker or robber). Who knows?

Use Tor
=======

Tor + Privoxy
-------------
I used this, working so bad so far, always pops out downloads in surf. Hopes
Polipo can filter which to site that is needed to be proxied.

Tor + Polipo (old)
------------------
I had dump Polipo since it must proxy everything to Tor. Setup Tor and Polipo.

Filter useless ads
------------------
/etc/polipo/forbidden

TorDNS + dnsmasq (cache)
------------------------
slow

Use Encryption
==============

Pretty Good Privacy (PGP)
-------------------------
GPG

### Mutt
Mutt build-in GPG support, require GPGME

Block-based Encryption
----------------------
dm-crypt + LUKS

File-based Encryption
---------------------
EncFS

Use encrypted connection
------------------------
If possible use, encrypted connection such as HTTPS, SMTPS, IMAPS.
Analyze with `tshark`.

Don't delete, shred files instead
---------------------------------
shred -xu

Misc
====

ROT13
-----
    tr 'A-Za-z' 'N-ZA-Mn-za-m'

Pen and Paper
-------------
I forgot the link (video).

Random Passphrase
-----------------
xkcd image

To easily generate a random passphrase using command line:

    aspell dump master | grep -v "'" | shuf -n 4 | tr '\n' ' '

What I did before this? I look it up online
<https://duckduckgo.com/?q=random+passphrase>.

Links
=====
leviathan
