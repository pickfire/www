LAYOUT=lay/menu.dhtml
DATE=$(date -ur $forig)
base=$(echo $forig|sed 's:/.*::')
for d in $(find $base -type d|grep -v '_\|img'); do
  echo $forig | grep -q $d && l=$l$(ls -Fd $PWD/$d/* | grep -v '_\|index\|img'):
done
NAV=$(for i in $(echo "$l"|tr : '\n'|sed "s|.*$base/||; s|\..*||"|sort); do
  echo $forig | grep -q $base/$i \
    && echo $i|sed "s|/$|_|; s|[^/]*/|  |g; s|_$|/|; s|\(\s*\)\(.*\)|\1- [_\u\2_](/$base/$i)|" \
    || echo $i|sed "s|/$|_|; s|[^/]*/|  |g; s|_$|/|; s|\(\s*\)\(.*\)|\1- [\u\2](/$base/$i)|"
done | cmark | sed 's/><em>/ class=site>/ g; s|</em>|| g')
