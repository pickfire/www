SSML
====

Generate a **static**, **minimal** site (*layout-based*) with a simple
**Makefile**.


            Usage: make -j4 (or any number you like)

    +--------------------+    +--------------------+    +--------------------+
    | layouts/main.dhtml |    | layouts/post.dhtml |    |  post/_www/config  |
    +--------------------+    +--------------------+    +--------------------+
    |<!DOCTYPE HTML>     |    |#-# vim:ft=html:    |    |LAYOUT=layouts/post+|
    |                    |    |LAYOUT=layouts/main+|    |DATE=$(date $forig) |
    |<html>              |    |F=$forig            |    |T=$(head -n $forig) |
    |<head>              |    |#-#                 |    +---------+----------+
    |  <title>${T}</titl+|    |                    |              |
    |</head>             |    |${F}                |    +---------+----------+
    |<body>              |    |====                |    |    post/test.md    |
    |  ${CONTENT}    <------  |${CONTENT}      <------  +--------------------+
    |</body>             |    |                    |    |- Hello World!      |
    |</html>             |    |Created by ${DATE}  |    |- cmark-powered     |
    +--------------------+    +--------------------+    +------------------- +
                                                                  ^
                  --- rm -rf $(TARG)/                             |
      +----------/                                                |
      |  clean   |        ./html.sh post/test.md > $(TARG)/post/test.html
      +==========+-----+ /
      | Makefile | all + ---- ./html.sh index.html > $(TARG)/index.html
      +==========+-----+ \
                 |        ------- ./atom.sh post/ > $(TARG)/%/atom.xml
          +------+--+
          |  check  | validate online -> ./check.sh $(TARG)
          +---------+
          |   gzip  | -> gzip -9k (all compress-able files)
          +---------+

Usage
-----

1. The `_www/config` found at the previous/current directory of the input file
   will be sourced, bash script and variables are optional.

2. Add bash functions/variables in between `#-#` lines at the beginning of the
   code, the second `#-#` must not have trailing characters. (optional)

3. In between those lines of code, add `LAYOUT=path/layout.dhtml` to paste the
   current content into `layout.dhtml`'s `${CONTENT}`.

4. Use `${VAR}` (must be uppercase) in files to substitute it to the variable,
   unused variables (line) will be deleted when generation is completed.

Need
----
* cmark: <https://github.com/jgm/cmark> (A commonmark implementation in C)
* mksh: <https://www.mirbsd.org/mksh.htm> (For a faster shell)
* bash: <http://www.gnu.org/software/bash/bash.html>
* GNU coreutils: <http://www.gnu.org/software/coreutils>
* GNU sed: <http://www.gnu.org/software/sed>
* GNU grep: <http://www.gnu.org/software/grep/grep.html>

Tool
----
- `atom.sh` - Find Markdown files and generate an Atom feed from it
- `html.sh` - Output HTML content with a file as input
- `check.sh` - Find HTML/CSS/XML files and verify it online

Info
----
Colorscheme: [Paper Color](https://github.com/NLKNguyen/papercolor-theme)
