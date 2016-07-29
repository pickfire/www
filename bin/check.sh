#!/usr/bin/env mksh
# Usage: check.sh file(s)
source config.sh

for l in $*; do
  case ${l} in
    *.css)  url="https://jigsaw.w3.org/css-validator/validator?uri=${l}";;
    *.xml)  url="https://validator.w3.org/feed/check.cgi?url=${l}";;
    *.html) url="https://html5.validator.nu/?doc=${l}";;
    *) url="";;
    # TODO: Add svg support
  esac
  [ "${url}" ] && curl -s ${url} | grep -Eq 'Sorry|errors' \
    && echo -e '[\e[1;31mFAIL\e[m]' ${url} >&2
done
