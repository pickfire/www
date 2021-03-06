include config.sh
.DEFAULT_GOAL = all
SXML  = | sed ':a;N;$$!ba;s/>\s*</></g'

# Source files
ABOUT != find about/ -type f \( -name '*.md' -o -name '*.shtml' \) -a ! -path '*_*'
POSTS != find posts/ -type f \( -name '*.md' -o -name '*.shtml' \) -a ! -path '*_*'
MENUS != find * -name 'index.*' -a ! -path '*_*'
MENUS += $(wildcard [0-9]*.md [0-9]*.shtml)
FEEDS := $(patsubst %, %atom.xml, $(dir $(POSTS))) posts/atom.xml
EXTRA != find * \( -name CNAME -o -name '*.png' -o -name '*.jpg' \
	-o -name '*.gif' -o -name '*.svg' -o -name '*.ico' -o -name '*.txt' \
	-o -name '*.css' -o -name '*.ogg' -o -name '*.pdf' \) -a ! -path '*_*'
PAGES := $(ABOUT) $(POSTS) $(MENUS)

# Requirements
OUTPUT := $(addprefix $(TARG)/, $(addsuffix .html, $(basename $(PAGES))) $(EXTRA) $(FEEDS))
LAYERS := $(wildcard _lay/*.dhtml _lay/*.sh)
NOINDX := $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))

# Dependencies
$(OUTPUT): config.sh config.mk

# TODO: Shorten this into a line
$(TARG)/posts/craft/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/craft/*.shtml))
$(TARG)/posts/learn/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/learn/*.shtml))
$(TARG)/posts/linux/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/linux/*.shtml))
$(TARG)/posts/index.html: $(filter-out %/index.shtml, $(wildcard $(TARG)/posts/*/*.shtml $(TARG)/posts/*.shtml))

# TODO: When there is a new file, the navigation bar should be updated (affect posts/about)
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config _lay/post.dhtml # TODO: find _www/config

$(TARG)/links/index.html.gz: ~/usr/doc/note/links.txt
