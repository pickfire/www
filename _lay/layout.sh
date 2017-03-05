echo "${body}" | sed '/${[A-Z]*}/ d; s|/index.html|/|g' &
exit
