include config.mk

all: $(addprefix $(TARG)/, $(PAGES:.md=.html) $(EXTRA) $(FEEDS)) map gzip

check: $(TARG) bin/check.sh
	bin/check.sh $</*
	wget --no-proxy --spider -r -nH -nd -np -nv -p $(SITE)

clean:
	rm -rf $(TARG)/*

map: bin/map.sh $(addprefix $(TARG)/, $(PAGES:.md=.html))
	@bin/map.sh

gzip: $(patsubst %, $(TARG)/%.gz, $(filter %.html %.xml %.txt %.css %.svg, \
	$(PAGES:.md=.html) $(EXTRA) $(FEEDS)))

push: all
	@cd $(TARG) && git add . && git commit -qm ∞ --amend && git push -qf && echo $@

$(TARG)/%.html: %.* bin/html.sh $(wildcard layouts/*.dhtml)
	@mkdir -p $(@D)
	bin/html.sh $< $(SXML) > $@

# TODO: Shorten this into a line if possible
$(TARG)/%/atom.xml: % bin/atom.sh $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))
	@mkdir -p $(@D)
	bin/atom.sh $< $(SXML) > $@

$(TARG)/%/rss.xml: % bin/rss.sh $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))
	@mkdir -p $(@D)
	bin/rss.sh $< $(SXML) > $@

$(TARG)/%.css: %.css bin/css.sed
	@mkdir -p $(@D)
	bin/css.sh $< > $@

$(TARG)/%: %
	cp -r $< --parents $(TARG)

$(TARG)/%.gz: $(TARG)/%
	@test `stat -c '%s' $<` -gt 200 && gzip -9kf $< > $@ ||:

.PHONY = all check clean map gzip push
.DEFAULT_GOAL = all
