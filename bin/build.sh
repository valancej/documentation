#!/bin/sh
set -e
log() { echo -e "\033[36m$@\033[39m"; }

# Special settings for the "master" branch, compile the site to the "master"
# subdirectory, but use an empty baseurl, so we can deploy to the bucket root
target="${CI_BRANCH}"
baseurl="/${CI_BRANCH}"
envname="dev"
if [ "${CI_BRANCH}" = "master" ]; then
	baseurl=""
	envname="production"
elif [ "${CI_BRANCH}" = ${staging/*} || "${CI_BRANCH}" = ${private/*} ]; then
	envname="staging"
fi

# Where do we want to generate the site at?
destination="/site/$target"
if [ "${destination}" != "/site/" ]; then
	rm -rf "${destination}" && mkdir -p "${destination}"
fi

# Jet release notes and current version
jet_source="/site/.jet"
if [ -f "_data/jet.yml" ]; then
	sed -i'' -e "s|^version:.*|version: $(cat ${jet_source}/version)|" "_data/jet.yml"
fi
if [ -f "_posts/docker/jet/2015-07-16-release-notes.md" ]; then
	cat "${jet_source}/release-notes" >> "_posts/docker/jet/2015-07-16-release-notes.md"
fi
rm -rf "${jet_source}"

# Compile the site
log "Building with base URL '${baseurl}'"
sed -i'' -e "s|^baseurl:.*|baseurl: ${baseurl}|" _config.yml
bundle exec JEKYLL_ENV=${envname} jekyll build --destination "${destination}"
