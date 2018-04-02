#!/bin/sh
# Update tor descriptors

d=/var/cache/dyn

find $d/descriptors/recent/exit-lists/ -mtime +1 -exec rm {} \;
wget -q --no-proxy --recursive --reject "index.html*" \
  --no-parent --no-host-directories --directory-prefix $d/descriptors \
  https://collector.torproject.org/recent/exit-lists/
/srv/tor/check/update | sort -n | uniq > $d/exits.txt
