LAYOUT=lay/layout.dhtml
TITLE="Pickfire if you dare. Hahaha"
for i in $(grep -sHm1 "^LINK=" */_www/config); do
  MENU+="<a href=/${i%%/*}>${i#*LINK=}</a>
"; done
