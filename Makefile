include config.mk

all: $(OUTPUT) map gzip

check: $(TARG) bin/check.sh
	find $(TARG) | sed "s|$(TARG)/|http://$(SITE)/|; s|:|%3A|; s|/|%2F|g" | xargs -x bin/check.sh
	wget --no-proxy --spider -r -nH -nd -np -nv -p $(SITE)

clean:
	rm -rf $(TARG)/*

map: bin/map.sh $(filter %.html, $(OUTPUT))
	@bin/map.sh

gzip: $(addsuffix .gz, $(filter %.html %.xml %.txt %.css %.svg, $(OUTPUT)))

sync: all
	@cd $(TARG) && git add . && git commit -qm ∞ --amend && git push -qf && echo $@

$(TARG)/%.html: %.shtml %.* bin/html.sh $(LAYERS) # TODO: Merge with the one below
	@mkdir -p $(@D)
	bin/html.sh $< $(SXML) > $@

$(TARG)/%.html: %.md %.* bin/html.sh $(LAYERS)
	@mkdir -p $(@D)
	bin/html.sh $< $(SXML) > $@

$(TARG)/%/atom.xml: % bin/atom.sh $(NOINDX)
	@mkdir -p $(@D)
	bin/atom.sh $< $(SXML) > $@

$(TARG)/%/rss.xml: % bin/rss.sh $(NOINDX)
	@mkdir -p $(@D)
	bin/rss.sh $< $(SXML) > $@

$(TARG)/%.css: %.css bin/css.sh
	@mkdir -p $(@D)
	bin/css.sh $< > $@

$(TARG)/%: %
	@mkdir -p $(@D)
	cp $< $@

$(TARG)/%.gz: $(TARG)/%
	@test `stat -t $<|cut -f2 -d\ ` -gt 200 && gzip -9kf $< > $@ ||:

.PHONY = all check clean map gzip push
.DEFAULT_GOAL = all
