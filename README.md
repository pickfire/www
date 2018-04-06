SSSG - Stupid Static Site Generator
===================================

SSSG is a layout-based static site generator built for parallelism and
minimalism while being flexible and feature-full. Think of it as a layer of
glue, which glues layers of papers into 3D models. It's perfect for simple
personal sites that adheres to the [KISS Principle][0] while being able to
follow the [Suckless Philosophy][1] and get rid of [Dependency Hell][2].

[0]: https://en.wikipedia.org/wiki/KISS_principle
[1]: http://suckless.org/philosophy
[2]: https://en.wikipedia.org/wiki/Dependency_hell

### Why SSSG?

It gives you the choice to be in control of your own site. But in return, you
need to give it love and time like a wise man once spoken: [“先苦后甜”][3].

[3]: http://www.zdic.net/sousuo/?q=%E5%85%88%E8%8B%A6%E5%90%8E%E7%94%9C


            Usage: make -j4 (or any number you like)
    
    +--------------------+    +--------------------+    +--------------------+
    |    _lay/main.sh    |    |    _lay/post.sh    |    |  post/_www/config  |
    +--------------------+    +--------------------+    +--------------------+
    |exit                |    |LAYOUT=_lay/main.dh+|    |LAYOUT=_lay/post.dh+|
    +---------+----------+    |F=$FILE             |    |DATE=$(date $FILE)  |
              |               +---------+----------+    |T=$(head -n $FILE)  |
    +---------+----------+              |               +---------+----------+
    |   _lay/main.dhtml  |    +---------+----------+              |
    +--------------------+    |   _lay/post.dhtml  |    +---------+----------+
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
                  --- rm -rf $(TARG)/*                            |
      +----------/                                                |
      |  clean   |        _bin/html.sh post/test.md > $(TARG)/post/test.html
      +==========+-----+ /
      | Makefile | all + ---- _bin/html.sh index.html > $(TARG)/index.html
      +==========+-----+ \
                 |        +------ _bin/atom.sh post/ > $(TARG)/%/atom.xml
                 |         \
                 |          -------- gzip -9 (needed) + cp (needed)
          +------+--+
          |  check  | validate html/css/xml online -> ./check.sh $(TARG)
          +---------+

The installation is simple, just make this your site:

    git clone git://git.pickfire.tk/www --depth 1
    rm -rf www/.git

Configurations can be done by editing `config.sh` and `config.mk`.

`_dyn/tor` needs to be manually linked to /srv/tor which uses fastcgi.

Rule
----

1. The `_www/config` found at the previous/current directory of the input file
   will be sourced, shell script and variables are optional.

2. Add shell functions/variables to file.sh (just change extension), these can
   aid in generating dynamic contents. E.g. menu

3. In between those lines of code, add `LAYOUT=_lay/layout.dhtml` to paste the
   current content into `layout.dhtml`'s `${CONTENT}`. (Required)

4. Use `${VAR}` (must be UPPERCASE) in files to substitute it to the variable,
   unused variables (line) will be deleted when generation is completed.

5. Makefile does not look for directories with names starting with `_`.

Need
----
* cmark: <https://github.com/jgm/cmark> (A commonmark implementation in C)
* mksh: <https://www.mirbsd.org/mksh.htm> (More features compare to dash)
* Compatible with GNU coreutils/sed/grep (required modification to `date`, check `ea401dcb`)

Tool
----
- `atom.sh`  - Find Markdown files and generate an Atom feed from it
- `check.sh` - Find HTML/CSS/XML files and verify it online
- `css.sh`   - Minify CSS files with sed and tr
- `html.sh`  - Output HTML content with a file as input
- `map.sh`   - Generate the sitemap and urllist

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
