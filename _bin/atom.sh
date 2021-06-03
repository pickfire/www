#!/bin/mksh
# Usage: atom.sh files (index.html won't be included)
. ./config.sh

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">

  <title>Pickfire ${1##*/}</title>
  <link href="${HOST}/${1##*/}"/>
  <updated>$(date -u +%Y-%m-%dT%TZ)</updated>
  <author>
    <name>Ivan Tham</name>
    <email>pickfire@riseup.net</email>
  </author>
  <id>${PROT}${HOST}/${1}/atom.xml</id>
	<link href="${HOST}/${1#/}/atom.xml"/>

EOF

for i in $(find ${1} -type f -name '*.md'|xargs stat -t|awk '{print $13,$1}' \
  |grep -v '_\|index'|sort -r|cut -f2 -d' '|head -n10); do
  cat <<EOF
  <entry>
    <title>$(grep '^[A-Z][a-z].*' ${i} | head -n1)</title>
    <link href="${PROT}${HOST}/${i%.md}"/>
    <updated>$(date -ud @`stat -t ${i}|cut -f13 -d\ ` +%Y-%m-%dT%TZ)</updated>
    <content type="html">
      <![CDATA[$(sed ':a;N;$!ba; s|.*<main>\(.*\)</main>.*|\1|' ${TARG}/${i%.md}.html)]]>
    </content>
  </entry>

EOF
done; echo "</feed>"
