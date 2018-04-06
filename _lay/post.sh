LAYOUT=_lay/menu.dhtml
DATE=$(date -ud @`stat -t $FILE | cut -f 13 -d ' '`)

d=${FILE%/*}

l=$(while p=$(realpath $PWD/$d); [ $PWD != $p ]; do
  echo $p/*; d=$d/..
done | xargs ls -Fd | grep -v 'img\|index\|_' | grep -E '.md$|.shtml$|/$')

NAV=$(for i in ${l}; do
  i=${i#*${FILE%%/*}}; i=${i%.*}           # Remove base and extension
  y=${i%/[a-zA-Z]*}; z=${i#${y}}           # Split $i into $y + $z
  x=$(echo $z | sed 's/.\(.\)/\u\1/')      # CamelCase
  s="${y//\//'  '}-"; s="${s//[a-zA-Z]/}"  # Spacing tree "  -"
  [ ${FILE#*${i}} != ${FILE} ] \
    && echo "${s//[a-z]/} [_${x#/}_](/${FILE%%/*}${y}${z})" \
    || echo "${s//[a-z]/} [${x}](/${FILE%%/*}${y}${z})"
done | cmark); NAV=${NAV//><em>/ class=site>}; NAV=${NAV//<\/em>/}
