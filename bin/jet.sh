#!/bin/sh
set -e
log() { echo -e "\033[36m$*\033[39m"; }

# configuration
target="/site/.jet"

log "Preparing Jet release notes and current version"
rm -rf "${target}" && mkdir -p "${target}/sync"
aws s3 sync "s3://${JET_RELEASE_BUCKET}/latest/" "${target}/"

# print the latest version
log "Latest version is $(cat "${target}/version")"
