LAYOUT=_lay/layout.dhtml
LINK=${forig%%/*}; LINK=$(tr [a-z] [A-Z] <<< ${LINK:0:1})${LINK:1} # CamelCase

for i in $(grep -sH "^LINK=" */_www/config); do
  MENU+="<a href=/${i%%/*}/"
  [ ${forig%%/*} = "${i%%/*}" ] && MENU+=" id='here'"
  MENU+=">${i#*LINK=}</a>"
done
