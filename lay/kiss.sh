LAYOUT=lay/layout.dhtml
TITLE="Pickfire if you dare. Hahaha"
for i in $(grep -sl "^TITLE" */index.*|grep -v _|sed 's|\.[a-z]*|\.|'); do
  ITEM=$ITEM"<a href=/${i}html>`sed -n 's/^TITLE=\"\(.*\)\"/\1/p' ${i}*`</a>
"; done
