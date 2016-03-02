SSSG - Simple Static Site Generator
===================================

SSSG is a layout-based static site generator built for parallelism and minimalism while being flexible and feature-full. Think of it as a layer of glue, which glues layers of papers into 3D models. It's perfect for simple personal sites that adheres to the [KISS Principle][0] while being able to follow the [Suckless Philosophy][1] and get rid of [Dependency Hell][2].

[0]: https://en.wikipedia.org/wiki/KISS_principle
[1]: http://suckless.org/philosophy
[2]: https://en.wikipedia.org/wiki/Dependency_hell

### Why SSSG?

It gives you the choice to be in control of your own site. But in return, you need to give it love and time like a wise man once spoken: [“先苦后甜”][3].

[3]: http://www.zdic.net/sousuo/?q=%E5%85%88%E8%8B%A6%E5%90%8E%E7%94%9C


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

The installation is simple, just make this your site:
```fish
git clone https://github.com/pickfire/sssg --depth 1
rm -rf sssg/.git
```
Rule
----

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

Help
----
- Personal help -> Email pickfire@riseup.net
- [Issue Tracker](https://github.com/pickfire/sssg/issues)
- [Pull Requests](https://github.com/pickfire/sssg/pulls)
- [Source code](http://git.pickfire.wha.la/sssg) ([Mirror](https://github.com/pickfire/sssg))

Inspiration
-----------
* [Paper Color Theme](https://github.com/NLKNguyen/papercolor-theme) as a nice
  color scheme
* [Statikiss framework project](https://github.com/moebiuseye/skf) which is
  another bash static site generator based on suckless
* [Suckless philosophy](http://suckless.org) which always focus to keep the
  code minimal
* [YAML frontmatter](https://jekyllrb.com/docs/frontmatter/) that enhance the
  features of a site generator

Alternative
-----------
* [Statikiss framework project](https://github.com/moebiuseye/skf) which is
  another bash static site generator inspired by suckless philosophy

Implementation
--------------
* [Pickfire's site](http://pickfire.wha.la/) ([Mirror](http://pickfire.github.io/))
* **Add your site here**
