LAYOUT=lay/menu.dhtml
DATE=$(date -ur $forig)

d=${forig%/*}
l=$(while p=$(realpath $PWD/$d); [ $PWD != $p ]; do
  echo $p/*; d+=/..
done | xargs ls -Fd | grep -v '_\|index\|img')

NAV=$(for i in ${l}; do
  i=${i#*${forig%%/*}}; i=${i%.*}          # Remove base and extension
  y=${i%/[a-zA-Z]*}; z=${i#${y}}           # Split $i into $y + $z
  x=$(tr [a-z] [A-Z] <<< ${z:1:1})${z:2}   # CamelCase
  s="${y//\//'  '}-"; s="${s//[a-zA-Z]/}"  # Spacing tree "  -"
  [[ $forig = *$i* ]] \
    && echo "${s//[a-z]/} [_${x#/}_](/${forig%%/*}${y}${z})" \
    || echo "${s//[a-z]/} [${x}](/${forig%%/*}${y}${z})"
done | cmark); NAV=${NAV//><em>/ class=site>}; NAV=${NAV//<\/em>/}
