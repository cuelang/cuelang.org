#!/usr/bin/env bash

set -eu

cd "${BASH_SOURCE%/*}"/../themes

# get_themes.sh ensures that the contents of /themes reflects
# the version control file located at /themes/versions.txt

while read -r line
do
	url=$(echo "$line" | cut -d' ' -f1)
	theme=$(basename $url)
	commit=$(echo "$line" | cut -d' ' -f2)
	rm -rf $theme
	git clone -q --recurse-submodules $url $theme
	pushd $theme > /dev/null
	git checkout -q $commit
	find -type d -name .git -prune -exec rm -rf '{}' \;
	popd > /dev/null
done < versions.txt
