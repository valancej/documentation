#!/bin/sh
set -e
log() { echo -e "\033[36m$@\033[39m"; }
action=${1:?'You need to pass an action!'} && shift

case "$action" in
	'sync')
		target="${CI_BRANCH}"
		if [ "${CI_BRANCH}" == "master" ]; then
			target="documentation"
		fi
		log "Pushing documenation to s3://${AWS_S3_BUCKET}/${target}/"
		aws s3 sync "/site/${target}/" "s3://${AWS_S3_BUCKET}/${target}/" --acl public-read --follow-symlinks --delete
		;;
	'configure_website')
		log "Pushing website configuration"
		config_file=${1:?'You need to pass an action!'} && shift
		aws s3api put-bucket-website --bucket "${AWS_S3_BUCKET}" --website-configuration "file://${config_file}"
		;;
	'configure_lifecycle')
		log "Pushing lifecycle configuration"
		config_file=${1:?'You need to pass an action!'} && shift
		aws s3api put-bucket-lifecycle --bucket "${AWS_S3_BUCKET}" --lifecycle-configuration "file://${config_file}"
		;;
	'robots')
		log "Pushing robots.txt file"
		aws s3 cp _robots.txt "s3://${AWS_S3_BUCKET}/robots.txt" --acl public-read
		;;
	*)
		log "Invalid action ${action} :("
		exit 1
		;;
esac
