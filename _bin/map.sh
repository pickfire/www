#!/bin/mksh
# Usage: map.sh
source config.sh

# Track file and dir changes (make only track file changes)
test -f ${TARG}/sitemap.xml \
  && test -z "$(find ${TARG}/ -newer ${TARG}/sitemap.xml \
    \( -type f -name *.html -o -type d \) )" && return 0

cat > ${TARG}/sitemap.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?><urlset>
$( (find ${TARG} -name '*.html' | sed "s|${TARG}|${HOST}|" | tee ${TARG}/urllist.txt) \
   | sed 's|^|<url><loc>|; s|$|</loc></url>|' | tr -d '\n')
</urlset>
EOF

gzip -9c ${TARG}/urllist.txt > ${TARG}/urllist.txt.gz
gzip -9c ${TARG}/sitemap.xml > ${TARG}/sitemap.xml.gz
brotli -9c ${TARG}/urllist.txt > ${TARG}/urllist.txt.br
brotli -9c ${TARG}/sitemap.xml > ${TARG}/sitemap.xml.br
