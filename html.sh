#!/usr/bin/env bash
# Usage: html.sh file

# Constants - Use $var, Globals - Use ${var}
forig=${1} # Original file (for scripts)
sep="#-#"
head="/^$sep/,/^$sep$/"
conf=_www/config

# Black magic, $1: file name (input)
abracadabra() {
  [[ $(head -n1 -c3 $1) == $sep ]] && source <(sed -n "$head p" $1)

  body=$(sed -e '/.*\${CONTENT}$/ r'<(echo "${body}") -e "$head d" $LAYOUT)
  for i in $(echo "${body}" | grep -o '${[A-Z]*}'); do # Variables: ${TITLE}
    [ -n "`eval echo $i`" ] && body="${body/$i/$(eval echo $i)}" 2>/dev/null
  done
}

d=$(dirname $1) # Greedy $conf sucker
while [ $(dirname $PWD) != $(realpath $PWD/$d) ]; do
  source $PWD/$d/$conf 2>/dev/null && abracadabra $1 || d+=/..
done

body="$([[ $1 =~ .md ]] && sed "$head d" $1 | cmark || sed "$head d" $1)"
while [ -z "$(echo "${body}" | grep -o !DOCTYPE)" ]; do # Just do it!
  abracadabra ${LAYOUT:-${1}}
done; echo "${body}" \
  | sed -e '/${[A-Z]*}/ d' -e 's|/index.html|/|g' -e '/^$/ d' #-e 's/^\s*</</g'
