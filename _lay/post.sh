LAYOUT=_lay/menu.dhtml
DATE=$(date -ud @`stat -t $FILE | cut -f 13 -d ' '`)

d=${FILE%/*}

l=$(while p=$(realpath $PWD/$d); [ $PWD != $p ]; do
  echo $p/*; d=$d/..
done | xargs ls -Fd | grep -v 'img\|index\|_' | grep -E '.md$|.shtml$|/$')

NAV=$(for i in ${l}; do
  j=${i#*${FILE%%/*}}                      # Remove base
  i=${j%.*}; z=${j#$i}; z=${z/.md/.html}   # Split extension $z
  x=${i%/[a-zA-Z]*}; y=${i#${x}}           # Split $i into $x + $y
  w=$(echo $y | sed 's/.\(.\)/\u\1/')      # CamelCase
  s="${x//\//'  '}-"; s="${s//[a-zA-Z]/}"  # Spacing tree "  -"
  [ ${FILE#*${i}} != ${FILE} ] \
    && echo "${s//[a-y]/} [_${w#/}_](/${FILE%%/*}${x}${y}${z})" \
    || echo "${s//[a-y]/} [${w}](/${FILE%%/*}${x}${y}${z})"
done | cmark); NAV=${NAV//><em>/ class=site>}; NAV=${NAV//<\/em>/}
