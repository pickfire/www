TITLE="Posts"
SUB="Expect the Unseen"
HEAD+='<link rel=stylesheet href="/pub/time.css">'
source config.sh
for i in $(find $(dirname $forig) -name '*.md' -type f -printf "%T@:%p\n" \
  |grep -v '_\|index\|.sh$'|sort -r|cut -f2 -d:|sed 's/\.md//'); do
  LIST+="<a href=\"/${i}\">$(sed -n '/^[A-Z][a-z].*/ p' ${i}.*|head -n1) \
<span class='date'>$(date '+%a %_d %b %Y' -ur ${i}.*)</span></a>
"; done
