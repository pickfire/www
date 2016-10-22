include config.sh
SXML  = | sed ':a;N;$$!ba;s/>\s*</></g'
PATH := $(HOME)/src/sbase:$(HOME)/src/ubase:/usr/bin

# Source files
ABOUT := $(shell find about/ -type f \( -name '*.md' -o -name '*.shtml' \) -a ! -path '*_*')
POSTS := $(shell find posts/ -type f \( -name '*.md' -o -name '*.shtml' \) -a ! -path '*_*')
MENUS := $(shell find * -name 'index.*' -a ! -path '*_*') \
	$(wildcard [0-9]*.md [0-9]*.shtml)
FEEDS := $(patsubst %, %atom.xml, $(dir $(POSTS))) posts/atom.xml \
	$(patsubst %, %rss.xml, $(dir $(POSTS))) posts/rss.xml
EXTRA := $(shell find * \( -name '*.png' -o -name '*.jpg' -o -name '*.gif' -o -name '*.svg' -o -name '*.ico' -o -name '*.txt' -o -name '*.css' -o -name '*.ogg' \) -a ! -path '*_*')
PAGES := $(ABOUT) $(POSTS) $(MENUS)

# Requirements
OUTPUT := $(addprefix $(TARG)/, $(addsuffix .html, $(basename $(PAGES))) $(EXTRA) $(FEEDS))
LAYERS := $(wildcard lay/*.dhtml lay/*.sh)
NOINDX := $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))

# Dependencies
$(OUTPUT): config.mk

# TODO: Shorten this into a line
$(TARG)/posts/craft/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/craft/*.shtml))
$(TARG)/posts/learn/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/learn/*.shtml))
$(TARG)/posts/linux/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/linux/*.shtml))
$(TARG)/posts/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/*/*.shtml $(TARG)/posts/*.shtml))

# TODO: When there is a new file, the navigation bar should be updated (affect posts/about)
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config lay/post.dhtml # TODO: find _www/config

$(TARG)/links/index.html.gz: ~/usr/doc/links.txt
