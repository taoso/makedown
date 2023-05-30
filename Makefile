MDs := $(shell find . -name '*.md')
HTMLs := $(MDs:.md=.html)
METAs := $(MDs:.md=.yml)

PWD := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

export ROOT_DIR = $(PWD)
export LUA_FILTER = $(PWD)/desc.lua

%.yml: %.md
	$(PWD)/meta.sh $< > $@

%.html: %.md head.tpl footer.tpl article.tpl
	pandoc -s -p --wrap=none \
		--toc \
		--mathml \
		--template article.tpl \
		--highlight-style=pygments \
		--lua-filter $(LUA_FILTER) \
		--from markdown+east_asian_line_breaks \
		$< -o $@

index: $(METAs)
	$(PWD)/index.sh .
	$(PWD)/feed.sh .

build: index $(HTMLs)

new:
	mkdir $(dir)
	cp -R $(PWD)/skeleton/ $(dir)

.PHONY: index all new
