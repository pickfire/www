LAYOUT=_lay/menu.dhtml
DATE=$(date -ud @`stat -t $forig | cut -f 13 -d ' '`)

d=${forig%/*}

l=$(while p=$(realpath $PWD/$d); [ $PWD != $p ]; do
  echo $p/*; d=$d/..
done | xargs ls -Fd | grep -v 'img\|index\|_' | grep -E '.md$|.shtml$|/$')

NAV=$(for i in ${l}; do
  i=${i#*${forig%%/*}}; i=${i%.*}          # Remove base and extension
  y=${i%/[a-zA-Z]*}; z=${i#${y}}           # Split $i into $y + $z
  x=$(echo $z | sed 's/.\(.\)/\u\1/')      # CamelCase
  s="${y//\//'  '}-"; s="${s//[a-zA-Z]/}"  # Spacing tree "  -"
  [[ $forig = *$i* ]] \
    && echo "${s//[a-z]/} [_${x#/}_](/${forig%%/*}${y}${z})" \
    || echo "${s//[a-z]/} [${x}](/${forig%%/*}${y}${z})"
done | cmark); NAV=${NAV//><em>/ class=site>}; NAV=${NAV//<\/em>/}
