LAYOUT=_lay/layout.dhtml
LINK=${FILE%%/*}; LINK=$(tr [a-z] [A-Z] <<< ${LINK:0:1})${LINK:1} # CamelCase

for i in $(grep -sH "^LINK=" */_www/config); do
  MENU+="<a href=/${i%%/*}/"
  [ ${FILE%%/*} = "${i%%/*}" ] && MENU+=" id='here'"
  MENU+=">${i#*LINK=}</a>&nbsp;"
done
