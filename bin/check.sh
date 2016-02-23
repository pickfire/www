#!/usr/bin/env bash
# Usage: check.sh file(s)
source <(sed -n "0,/^#-#/ p" config.mk)

site=http:%2F%2Fpickfire.wha.la%2F
declare -i html css xml fhtml fcss fxml

check () {
  [ -n "$(curl -s "${1}" | egrep -o 'Sorry|errors')" ] \
    && echo -e "[\e[1;31mFAIL\e[0m] ${1}" >&2 && eval f${1##*.}+=1 || eval ${1##*.}+=1
}

for l in $(find $* -type f | sed "s|${TARG}/||; s|/|%2F|g" | uniq); do
  case ${l} in
    *.css)  check "https://jigsaw.w3.org/css-validator/validator?uri=${site}${l}";;
    *.xml)  check "https://validator.w3.org/feed/check.cgi?url=${site}${l}";;
    *.html) check "https://html5.validator.nu/?doc=${site}${l}";;
    # TODO: Add svg support
    *) continue;;
  esac
done

for i in html css xml; do # Report
  [ -z "$(eval echo '$'$i'$'f$i)" ] && continue
  echo -ne "[    ] \e[32m$(eval printf %3s '$'$i)\e[m / \e[31m$(eval printf %3s '$'f$i)\e[m $i\r["
  [ -z "$(eval echo '$'f$i)" ] && echo -e "\e[1;32m OK\e[m" || echo -e "\e[1;31mFAIL\e[m"
done
