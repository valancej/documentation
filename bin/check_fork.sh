#!/bin/sh
set -e
fail() { echo -e "\033[31m$@\033[39m"; exit 1; }

# TODO
# currently CI_REPO_NAME only contains the repository name, but not the owner,
# git metadata isn't available, because the .git folder is in the .dockerignore
# file. So we only match the name for now.
# Switch to owner/repository or the full remote URL once this is available.

# Break if we're on Codeship.com, the master branch, but not the
# https://github.com/codeship/documentation repository
if [ "${CI}" = "true" -a "${CI_BRANCH}" = "master" -a  "${CI_REPO_NAME}" != "documentation" ]; then
	 fail "Builds for the ${CI_BRANCH} branch are only run for the codeship/documentation repository!"
fi
