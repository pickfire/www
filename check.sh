#!/usr/bin/env bash
# Usage: check.sh file(s)

source <(sed -n "0,/^#-#/ p" Makefile)
site=pickfire.wha.la

for l in $(find $* -type f|uniq); do
  case ${l#${TARG}/} in
    *.css)  check="https://jigsaw.w3.org/css-validator/validator?uri=${site}/${l#${TARG}/}";;
    *.xml)  check="https://validator.w3.org/feed/check.cgi?url=${site}/${l#${TARG}/}";;
    *.html) check="https://html5.validator.nu/doc?uri=${site}/${l#${TARG}/}";;
  esac

  # Error! Diagnosing...
  [ -n "$(curl -s "${check}" | egrep -o 'Invalid|Sorry')" ] \
    && echo -e "[\e[1;31mFAIL\e[0m] ${check}" # Debug: use ${check}
done
