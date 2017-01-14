#!/usr/bin/env mksh
# Usage: rss.sh files (index.html won't be included)
source config.sh

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">

  <channel>
  <title>Pickfire ${1##*/}</title>
  <description>Pick fire if you dare! hahaha</description>
  <link>${PROT}${SITE}/${1}/rss.xml</link>
  <pubDate>$(date -u +'%a, %d %b %Y %T %z')</pubDate>

EOF

for i in $(find ${1} -type f -name '*.md'|xargs stat -t|awk '{print $13,$1}' \
  |grep -v '_\|index'|sort -r|cut -f2 -d' '|head -n10); do
  cat <<EOF
  <item>
    <title>$(grep '^[A-Z][a-z].*' ${i} | head -n1)</title>
    <link>${PROT}${SITE}/${i%.md}</link>
    <pubDate>$(date -ud `stat -t ${i}|cut -f13 -d\ ` +'%a, %d %b %Y %T %z')</pubDate>
    <description><![CDATA[
    $(sed ':a;N;$!ba; s|.*<main>\(.*\)</main>.*|\1|' ${TARG}/${i%.md}.html)
    ]]></description>
	</item>

EOF
done; echo "</channel></rss>"
