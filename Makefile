include config.mk

all: $(wildcard config.*) $(OUTPUT) map gzip

check: $(TARG) _bin/check.sh
	wget --no-proxy --spider -r -nH -nd -np -nv -p $(HOST)
	find $(TARG) | sed "s|$(TARG)/|http://$(HOST)/|; s|:|%3A|; s|/|%2F|g" | xargs -x _bin/check.sh

clean:
	rm -rf $(TARG)/*

map: _bin/map.sh $(filter %.html, $(OUTPUT))
	@_bin/map.sh

gzip: $(addsuffix .gz, $(filter %.html %.xml %.txt %.css %.svg, $(OUTPUT)))

sync: all
	@cd $(TARG) && git add . && git commit -qm ∞ --amend && git push -qf && echo $@

$(TARG)/%.html: %.shtml %.* _bin/html.sh $(LAYERS) # TODO: Merge with the one below
	@mkdir -p $(@D)
	_bin/html.sh $< $(SXML) > $@

$(TARG)/%.html: %.md %.* _bin/html.sh $(LAYERS)
	@mkdir -p $(@D)
	_bin/html.sh $< $(SXML) > $@

$(TARG)/%/atom.xml: % _bin/atom.sh $(NOINDX)
	@mkdir -p $(@D)
	_bin/atom.sh $< $(SXML) > $@

$(TARG)/%.css: %.css _bin/css.sh
	@mkdir -p $(@D)
	_bin/css.sh $< > $@

$(TARG)/%: %
	@mkdir -p $(@D)
	cp $< $@

$(TARG)/%.gz: $(TARG)/%
	@test `stat -t $<|cut -f2 -d\ ` -gt 200 && gzip -9cf $< > $@ ||:

.PHONY: all check clean map gzip sync
