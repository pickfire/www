include config.mk

all: $(addprefix $(TARG)/, $(PAGES:.md=.html) $(EXTRA) $(FEEDS))

check: $(TARG) bin/check.sh
	bin/check.sh $</*

clean:
	rm -rf $(TARG)/*

gzip: all
	gzip -9kf $(shell find $(TARG) -name '*.*ml' -o -name '*.css' -o -name '*.txt')

push: gzip
	@cd $(TARG) && git add . && git commit -qm ∞ --amend && git push -qf && echo $@

$(TARG)/%.html: %.* html.sh $(wildcard layouts/*.dhtml)
	@mkdir -p $(@D)
	./html.sh $< > $@

$(TARG)/%/atom.xml: % atom.sh $(filter-out %/index.html, $(addprefix $(TARG)/, $(POSTS:.md=.html)))
	@mkdir -p $(@D)
	./atom.sh $< > $@

$(TARG)/%.css: %.css bin/css.sed
	@mkdir -p $(@D)
	bin/css.sed $< | tr -d '\n' > $@

$(TARG)/%: %
	cp -r $< --parents $(TARG)

.PHONY = all check clean gzip push
.DEFAULT_GOAL = all
