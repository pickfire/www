#!/usr/bin/env mksh
# Usage: rss.sh files (index.html won't be included)
source config.sh

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>Pickfire $(echo $1 | sed 's|.*/\([a-z]*\)[^a-z]*|\1|')</title>
<link>${SITE}/${1}/rss.xml</link>
<pubDate>$(TZ='UTC' date -u +'%Y-%m-%dT%H:%M:%SZ')</pubDate>
<author>
<name>Ivan Tham</name>
<email>pickfire@riseup.net</email>
</author>
EOF

for i in $(find ${1} -type f -name '*.md' -printf "%T@:%p\n"|grep -v '_\|index'\
  |sort -r|cut -f2 -d:|sed 's/\.md//'|head -n10); do cat <<EOF
<item>
<title>$(grep '^[A-Z][a-z].*' ${i}.md | head -n1)</title>
<link>${SITE}/${i}</link>
<pubDate>$(TZ='UTC' date -ur ${i}.md +'%Y-%m-%dT%H:%M:%SZ')</pubDate>
<description><![CDATA[
$(sed ':a;N;$!ba; s|.*<div id="main">\(.*\)</div>.*|\1|' ${TARG}/${i}.html)
]]></description></item>
EOF
done && echo "</channel></rss>"
