#!/usr/bin/env bash
# Usage: check.sh file(s)
source <(sed -n "0,/^#-#/ p" config.mk)

site=http:%2F%2Fpickfire.wha.la%2F

check() {
  case ${1} in
    *.css)  curl -s "https://jigsaw.w3.org/css-validator/validator?uri=${1}";;
    *.xml)  curl -s "https://validator.w3.org/feed/check.cgi?url=${1}";;
    *.html) curl -s "https://html5.validator.nu/?doc=${1}";;
    # TODO: Add svg support
  esac | egrep -qo 'Sorry|errors' \
    && echo -e '[\e[1;31mFAIL\e[m]' ${1//'%2F'/'/'} >&2
}; export -f check

find $* -type f | sed "s|${TARG}/|${site}|; s|/|%2F|g" | uniq | parallel -uj400% check
