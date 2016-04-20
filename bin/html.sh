#!/usr/bin/env mksh
# Usage: html.sh file

# Constants - Use $var, Globals - Use ${var}
forig=${1} # Original file (for scripts)
conf=_www/config

# Black magic, $1: file name (input)
abracadabra() {
  [ -f ${1%.*}.sh ] && source ${1%.*}.sh

  lay=$(cat $LAYOUT)
  body=${lay/'${CONTENT}'/${body:-${lay}}} # ${CONTENT} substitution

  for i in $(grep -o '${[A-Z]*}' <<< ${body}); do # Variables: ${TITLE}
    j=$(eval echo $i)
    [ -n "$j" ] && body=${body//$i/${j//> </'>\n<'}}
  done
}

d=${1%/*} # Greedy $conf sucker
while [ $(dirname $PWD) != $(realpath $PWD/$d) ]; do
  source $PWD/$d/$conf 2>/dev/null && abracadabra $1 || d+=/..
done

body="$([ ${1##*.} = 'md' ] && cmark $1 || cat $1)" # Markdown -> HTML
LAYOUT=${LAYOUT:-${1}}; while :; do
  abracadabra ${LAYOUT} # Just do it!
done
