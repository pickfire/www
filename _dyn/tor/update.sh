#!/bin/sh
# Update tor lists

d=/var/cache/dyn

# Mirror tor concensus directory
wget --no-verbose --no-proxy --recursive --reject "index.html*" --no-parent --no-host-directories --directory-prefix $dyn/descriptors https://collector.torproject.org/recent/exit-lists/
./update | sort -n | uniq > $d/exits.txt
