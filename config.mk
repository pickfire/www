TARG = /srv/http
#TARG = _site
SITE = http://pickfire.wha.la/
SXML = sed -

ABOUT = $(shell find about/[^_]* -type f -name '*.md')
POSTS = $(shell find posts/[^_]* -type f -name '*.md')
MENUS = $(wildcard [0-9]*.*) $(shell find [^_]* -name 'index.*')
FEEDS = $(patsubst %, %atom.xml, $(dir $(POSTS))) posts/atom.xml \
	$(patsubst %, %rss.xml, $(dir $(POSTS))) posts/rss.xml
EXTRA = $(shell find -name '*.png' -o -name '*.jpg' -o -name '*.gif' -o -name '*.txt') $(wildcard css/*.css)
PAGES = $(ABOUT) $(POSTS) $(MENUS)

# Dependencies
# TODO: Shorten this into a line
$(TARG)/posts/craft/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/craft/*.html))
$(TARG)/posts/learn/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/learn/*.html))
$(TARG)/posts/linux/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/linux/*.html))
$(TARG)/posts/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/*/*.html $(TARG)/posts/*.html))

# TODO: When there is a new file, the navigation bar should be updated (affect posts/about)
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config # TODO: find _www/config

$(TARG)/links/index.html: ~/usr/doc/links.txt
