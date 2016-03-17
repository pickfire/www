#!/usr/bin/env mksh
# Usage: html.sh file

# Constants - Use $var, Globals - Use ${var}
forig=${1} # Original file (for scripts)
sep="#-#"; head="/^$sep/,/^$sep$/"
conf=_www/config
markdown=cmark

# Black magic, $1: file name (input)
abracadabra() {
  [ $(head -n1 -c3 $1) == $sep ] && source $1 2>/dev/null

  [ $? -eq 3 ] && echo "${body}" | sed '/${[A-Z]*}/ d; s|/index.html|/|g' \
    | sed ':a;N;$!ba;s/>\s*</></g' && exit # exit if 3 is returned

  body=$([ -z "${body}" ] && sed "$head d" $LAYOUT || sed -e "/\${CONTENT}$/ c\
$(echo "${body}"|sed '$! s/$/\\/')" -e "$head d" $LAYOUT) # TODO: \ fails here

  for i in $(echo "${body}" | grep -o '${[A-Z]*}'); do # Variables: ${TITLE}
    [ -n "$(eval echo $i)" ] && body="${body/$i/$(eval echo $i)}" 2>/dev/null
  done
}

d=$(dirname $1) # Greedy $conf sucker
while [ $(dirname $PWD) != $(realpath $PWD/$d) ]; do
  source $PWD/$d/$conf 2>/dev/null && abracadabra $1 || d+=/..
done

body="$([[ $1 == *.md ]] && sed "$head d" $1 | $markdown || sed "$head d" $1)"
LAYOUT=${LAYOUT:-${1}}; while :; do
  abracadabra ${LAYOUT} # Just do it!
done
