#!/usr/bin/env python3
# Prototype of update.c
# Lesser output compared to update.c
# Requirements: python-dateutil==2.1, stem==1.4.1

from os import listdir

from stem.descriptor import parse_file
from stem.exit_policy import ExitPolicy

descriptor_path = "/var/cache/dyn/descriptors/recent/exit-lists/"

exits = {} # Ignore duplicated exits

for d in listdir(descriptor_path):
    with open(descriptor_path + d, 'rb') as f:
        for r in parse_file(f, validate = True):
            if r.fingerprint in exits or r.fingerprint is None:
                continue
            for ip in r.exit_addresses:
                print(ip[0])
            exits[r.fingerprint] = 0
