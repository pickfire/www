#!/usr/bin/env bash
# Usage: config.sh files (index.html won't be included)
source <(sed -n "0,/^#-#/ p" Makefile)

cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
<title>Pickfire $(echo $1 | sed 's|.*/\([a-z]*\)[^a-z]*|\1|')</title>
<id>${SITE}${1}/atom.xml</id><link href="${SITE}${1}/atom.xml"/>
<updated>$(TZ='UTC' date -u +'%Y-%m-%dT%H:%M:%SZ')</updated>
<author>
<name>Ivan Tham</name>
<email>pickfire@riseup.net</email>
</author>
EOF

for i in $(find ${1} -type f -name '*.md' -printf "%T@:%p\n"|grep -v '_\|index'|sort -r|cut -f2 -d:|sed "s|\.md||"); do cat <<EOF
<entry><title>$(grep '^[A-Z][a-z].*' ${i}.md | head -n1)</title>
<id>${SITE}${i}</id><link href="${SITE}${i}"/>
<updated>$(TZ='UTC' date -ur ${i}.md +'%Y-%m-%dT%H:%M:%SZ')</updated>
<content type="html"><![CDATA[
$(sed '0,/<div id="content">/ d' ${TARG}/${i}.html|tac|sed '0,/<\/div>/ d'|tac)
]]></content></entry>
EOF
done && echo "</feed>"
