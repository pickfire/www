#!/bin/mksh
# Usage: html.sh file
. ./config.sh
# Constants - Use $var, Globals - Use ${var}
FILE=${1} # Original file (for scripts)

# Black magic, $1: file name (input)
abracadabra() {
  [ -f ${1%.*}.sh ] && . ./${1%.*}.sh

  lay=$(cat $LAYOUT)
  body=${lay/'${CONTENT}'/${body:-${lay}}} # ${CONTENT} substitution

  for i in $(tr '<> ' '\n' <<< ${body}|grep '${[A-Z]*}'); do # ${TITLE}
    j=$(eval echo \"$i\")
    [ -n "$j" ] && body=${body//$i/${j//> </'>\n<'}}
  done
}

d=${1%/*} # Greedy _www/config sucker
while [ ${PWD%/*} != $(realpath $PWD/$d) ]; do # Check until rootdir
  source $PWD/$d/_www/config 2>/dev/null && abracadabra $1 || d+=/..
done

body="$([ ${1##*.} = 'md' ] && cmark $1 || cat $1)" # Markdown -> HTML
LAYOUT=${LAYOUT:-${1}}; while :; do
  abracadabra ${LAYOUT} # Just do it!
done
