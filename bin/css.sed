#!/usr/bin/sed -f
# Simple sed script to minify the css file

# Remove comments
s#\/\*.*\*\/##g
/\/\*/,/\*\// d

# Remove spacings
s/\s*{/{/g
s/:\s*/:/g
s/,\s*/,/g

# Header x Footer
s/^\s*//
s/\s*$//
