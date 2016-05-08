#!/usr/bin/mksh
# Usage: css.sh file

sed -e '
# Remove comments
s#\/\*.*\*\/##g
/\/\*/,/\*\// d

# Remove spacings
s/\s*{\s*/{/g
s/\([:,;]\)\s*/\1/g

# Header x Footer
s/^\s*//
s/\s*$//
' $1 | tr -d '\n' | sed 's/;}/}/g'
