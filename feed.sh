#!/usr/bin/env bash

updated=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

if [[ -f $1/env ]]; then
	set -o allexport
	source $1/env
	set +o allexport
fi

pandoc -s -p -f markdown -t html --wrap=none \
	--metadata=updated:$updated \
	--metadata-file=$1/index.yml \
	--template $ROOT_DIR/feed.tpl \
	--lua-filter $LUA_FILTER \
	-o $1/feed.xml /dev/null

pandoc -s -p -f markdown -t html --wrap=none \
	--metadata=updated:$updated \
	--metadata-file=$1/index.yml \
	--template $ROOT_DIR/map.tpl \
	--lua-filter $LUA_FILTER \
	-o $1/map.xml /dev/null
