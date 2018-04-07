TITLE="Posts"
SUB="Expect the Unseen"

for i in $(find ${FILE%/*} -name '*.md' -type f|xargs stat -t|awk '{print $13,$1}' \
  |grep -v '_\|index\|.sh$'|sort -r|cut -f2 -d' '|sed 's/\.md//'); do
  LIST+="<a href=\"/${i}.html\">$(sed -n '/^[A-Z][a-z].*/ p' ${i}.*|head -n1) \
<span class='date'>$(date -ud @`stat -t ${i}.*|cut -f13 -d\ ` +'%a %d %b %Y')</span></a>
"; done
