TARG = /srv/http
#TARG = _site
SITE = http://pickfire.wha.la/
SXML = | sed ':a;N;$$!ba;s/>\s*</></g'

ABOUT = $(shell find about/ -type f -name '*.md' -a ! -path '*_*')
POSTS = $(shell find posts/ -type f -name '*.md' -a ! -path '*_*')
MENUS = $(shell find -name 'index.*' -a ! -path '*_*') \
	$(wildcard [0-9]*.md [0-9]*.shtml)
FEEDS = $(patsubst %, %atom.xml, $(dir $(POSTS))) posts/atom.xml \
	$(patsubst %, %rss.xml, $(dir $(POSTS))) posts/rss.xml
EXTRA = $(shell find -name '*.png' -o -name '*.jpg' -o -name '*.gif' -o -name '*.svg' -o -name '*.txt' | grep -v '_') \
	$(wildcard pub/*.css)
PAGES = $(ABOUT) $(POSTS) $(MENUS)

# Dependencies
# TODO: Shorten this into a line
$(TARG)/posts/craft/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/craft/*.shtml))
$(TARG)/posts/learn/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/learn/*.shtml))
$(TARG)/posts/linux/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/linux/*.shtml))
$(TARG)/posts/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/*/*.shtml $(TARG)/posts/*.shtml))

# TODO: When there is a new file, the navigation bar should be updated (affect posts/about)
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config lay/post.dhtml # TODO: find _www/config

$(TARG)/links/index.html: ~/usr/doc/links.txt
