#!/usr/bin/env mksh
# Usage: atom.sh files (index.html won't be included)
source config.sh

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
<title>Pickfire ${1##*/}</title>
<id>${SITE}/${1}/atom.xml</id><link href="${SITE}/${1}/atom.xml">
<updated>$(TZ='UTC' date -u +'%Y-%m-%dT%H:%M:%SZ')</updated>
<author>
<name>Ivan Tham</name>
<email>pickfire@riseup.net</email>
</author>
EOF

for i in $(find ${1} -type f -name '*.md' -printf "%T@:%p\n"|grep -v '_\|index'\
  |sort -r|cut -f2 -d:|head -n10); do
  cat <<EOF
<entry>
<title>$(grep '^[A-Z][a-z].*' ${i} | head -n1)</title>
<id>${SITE}/${i%.md}</id><link href="${SITE}/${i%.md}">
<updated>$(TZ='UTC' date -ur ${i} +'%Y-%m-%dT%H:%M:%SZ')</updated>
<content type="html"><![CDATA[
$(sed ':a;N;$!ba; s|.*<div id="main">\(.*\)</div>.*|\1|' ${TARG}/${i%.md}.html)
]]></content></entry>
EOF
done; echo "</feed>"
