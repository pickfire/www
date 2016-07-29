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
    |   layouts/main.sh  |    |   layouts/post.sh  |    |  post/_www/config  |
    +--------------------+    +--------------------+    +--------------------+
    |return 4            |    |LAYOUT=layouts/main+|    |LAYOUT=layouts/post+|
    +---------+----------+    |F=$forig            |    |DATE=$(date $forig) |
              |               +---------+----------+    |T=$(head -n $forig) |
    +---------+----------+              |               +---------+----------+
    | layouts/main.dhtml |    +---------+----------+              |
    +--------------------+    | layouts/post.dhtml |    +---------+----------+
    |<!DOCTYPE html>     |    +--------------------+    |    post/test.md    |
    |<html>              |    |${F}                |    +--------------------+
    |  <head>            |    |====                |    |Why?                |
    |    <title>${T}</ti+|    |                    |    |----                |
    |  <head>            |    |${CONTENT}      <------  |- Parallel and fast |
    |  <body>            |    |                    |    |- Markdown-powered  |
    |    ${CONTENT}  <------  |---                 |    |- Minimal outputs   |
    |    ...             |    |Created by ${DATE}  |    |- Flexiblility++    |
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
    
    The format isn't fixed currently, it might change to use return as ending.

The installation is simple, just make this your site:
```fish
git clone https://github.com/pickfire/sssg --depth 1
rm -rf sssg/.git
```
Configurations can be done by editing `config.sh` and `config.mk`.

`dyn/tor` needs to be manually linked to /srv/tor which uses uwsgi.

Rule
----

1. The `_www/config` found at the previous/current directory of the input file
   will be sourced, shell script and variables are optional.

2. Add shell functions/variables after adding `#-#` at the beginning of the file
   and end with a `return`/`return 3` (to exit `source`) follow by a `#-#`
   without any trailing characters.

3. In between those lines of code, add `LAYOUT=path/layout.dhtml` to paste the
   current content into `layout.dhtml`'s `${CONTENT}`. (Required)

4. Use `${VAR}` (must be uppercase) in files to substitute it to the variable,
   unused variables (line) will be deleted when generation is completed.

Need
----
* cmark: <https://github.com/jgm/cmark> (A commonmark implementation in C)
* mksh: <https://www.mirbsd.org/mksh.htm> (More features compare to dash)
* sbase/ubase: <http://core.suckless.org/> (½ faster than GNU coreutils)

* Compatible with GNU coreutils/sed/grep (required modification to `date`, check `ea401dcb`)

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
- [Source code](http://git.pickfire.tk/sssg) ([Mirror](https://github.com/pickfire/sssg))

Inspiration
-----------
* [Paper Color Theme](https://github.com/NLKNguyen/papercolor-theme) as a nice
  color scheme
* [Statikiss framework project](https://github.com/moebiuseye/skf) which is
  another static site generator based on suckless
* [Suckless philosophy](http://suckless.org) which always focus to keep the
  code minimal
* [YAML frontmatter](https://jekyllrb.com/docs/frontmatter/) that enhance the
  features of a site generator
* [Device Ready](https://deviceready.net/building-with-make) such a small
  beautiful site

Alternative
-----------
* [Statikiss framework project](https://github.com/moebiuseye/skf) which is
  a bash static site generator inspired by suckless philosophy

Implementation
--------------
* [Pickfire's site](http://pickfire.tk/) ([Mirror](http://pickfire.github.io/))
* **Add your site here**
