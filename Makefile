TARG=/srv/http  # Use _site for testing
SITE=http://pickfire.wha.la/
#-# Needed for other scripts TODO: consider moving this to config.mk

ABOUT = $(shell find about/[^_]* -type f -name '*.md')
POSTS = $(shell find posts/[^_]* -type f -name '*.md')
MENUS = $(wildcard [0-9]*.*) $(shell find [^_]* -name 'index.*')
FEEDS = $(patsubst %, %atom.xml, $(dir $(POSTS))) posts/atom.xml
EXTRA = $(wildcard css/* img/* txt/*)
PAGES = $(ABOUT) $(POSTS) $(MENUS)

all: $(addprefix $(TARG)/, $(PAGES:.md=.html) $(EXTRA) $(FEEDS))

check: $(TARG) check.sh
	./check.sh $<

clean:
	rm -rf $(TARG)/*

gzip:
	gzip -9kf $(shell find $(TARG) -name '*.*ml' -o -name '*.css' -o -name '*.txt')

# TODO: Shorten this into a line
$(TARG)/posts/craft/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/craft/*.html))
$(TARG)/posts/learn/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/learn/*.html))
$(TARG)/posts/linux/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/linux/*.html))
$(TARG)/posts/index.html: $(filter-out %/index.html, $(wildcard $(TARG)/posts/*/*.html))

# TODO: When there is a new file, the navigation bar should be updated (affect posts/about)
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config # TODO: find _www/config

$(TARG)/%.html: %.* config.sh $(wildcard layouts/*.dhtml)
	@mkdir -p $(@D)
	./config.sh $< > $@

$(TARG)/%/atom.xml: % atom.sh $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))
	@mkdir -p $(@D)
	./atom.sh $< > $@

$(addprefix $(TARG)/, $(EXTRA)): $(TARG)/%: %
	cp -r $< --parents $(TARG)

.PHONY: all gzip check clean
