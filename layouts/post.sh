LAYOUT=layouts/menu.dhtml
DATE=$(date -ur $forig)
HEAD=$([[ $forig == *posts* ]] && echo "<link href=/$(dirname $forig)/atom.xml type=application/atom+xml rel=alternate title=\"Pickfire $(basename $(dirname $forig)) ATOM Feed\">
<link href=/$(dirname $forig)/atom.xml type=application/rss+xml rel=alternate title=\"Pickfire $(basename $(dirname $forig)) RSS Feed\">
${HEAD}")
base=$(echo $forig|sed 's:/.*::')
for d in $(find $base -type d); do
  [[ $forig == *$d* ]] && l+=$(ls -Fd $PWD/$d/* | grep -v '_\|index\|img'):
done
NAV=$(for i in $(echo "$l"|tr : '\n'|sed "s|.*$base/||; s|\..*||"|sort); do
  [[ $forig == *$base/$i* ]] \
    && echo $i|sed "s|/$|_|; s|[^/]*/|  |g; s|_$|/|; s|\(\s*\)\(.*\)|\1- [_\u\2_](/$base/$i)|" \
    || echo $i|sed "s|/$|_|; s|[^/]*/|  |g; s|_$|/|; s|\(\s*\)\(.*\)|\1- [\u\2](/$base/$i)|"
done | cmark | sed 's/><em>/ class=site>/ g; s|</em>|| g')
