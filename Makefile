TARG=/srv/http
SITE=http://pickfire.wha.la/
#-# Needed for other scripts

ABOUT = $(shell find about/[^_]* -type f -name '*.md')
POSTS = $(shell find posts/[^_]* -type f -name '*.md')
MENUS = $(wildcard [0-9]*.*) $(shell find [^_]* -name 'index.*')
FEEDS = $(patsubst %, %atom.xml, $(dir $(POSTS)))
EXTRA = $(wildcard css/* img/* txt/*)
PAGES = $(ABOUT) $(POSTS) $(MENUS)

all: $(addprefix $(TARG)/, $(PAGES:.md=.html) $(EXTRA) $(FEEDS))

check: $(TARG) check.sh
	./check.sh $<

clean:
	rm -rf $(TARG)/*

gzip:
	gzip -9kf $(shell find $(TARG) -name '*.*ml' -o -name '*.css' -o -name '*.txt')

$(TARG)/posts/index.md: $(addprefix $(TARG)/, $(POSTS:.md=.html))
$(addprefix $(TARG)/, $(POSTS:.md=.html)): posts/_www/config # TODO: find _www/config

$(TARG)/%.html: %.* config.sh $(wildcard layouts/*.dhtml)
	@mkdir -p $(@D)
	./config.sh $< > $@

$(TARG)/%/atom.xml: % atom.sh $(addprefix $(TARG)/, $(POSTS:.md=.html))
	@mkdir -p $(@D)
	./atom.sh $< > $@

$(addprefix $(TARG)/, $(EXTRA)): $(TARG)/%: %
	cp -r $< --parents $(TARG)

.PHONY: all gzip check clean
