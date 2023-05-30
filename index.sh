#!/usr/bin/env bash

find $1 -type d | while read dir; do

no_child=""

if [[ -f $dir/env ]]; then
	set -o allexport
	source $dir/env
	set +o allexport
fi

if [[ ! -z "$no_child" ]]; then
	if [[ "$dir" != "." ]]; then
		continue
	fi
fi

yml=$dir/index.yml
echo "title: $site_title" > $yml
echo "articles:" >> $yml

find $dir -name '*.yml' \
	! -name "draft-*.yml" \
	! -name "index.yml" \
	! -name "feed.yml" \
	-exec cat {} + | sort -r >> $yml

# there is no *.md file
if [[ "$(tail -n 1 $yml)" == "articles:" ]]; then
	rm $yml
	continue
fi

index=$dir/index.html

pandoc -s -p -f markdown --wrap=none \
	--template index.tpl \
	--metadata-file=$yml \
	--lua-filter $LUA_FILTER \
	-o $index /dev/null

[ -s $index ] || rm $index

done
