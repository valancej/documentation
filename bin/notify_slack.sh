#!/bin/sh
set -e
log() { echo -e "\033[36m$@\033[39m"; }

: ${SLACK_WEBHOOK_URL:="https://hooks.slack.com/services/$SLACK_WEBHOOK_PATH"}
: ${SLACK_USERNAME:="Cotton's Parrot"}

# build the message payload
payload=$(cat <<EOT
payload={
	"channel": "${SLACK_CHANNEL}",
	"username": "${SLACK_USERNAME}",
	"icon_emoji": ":boat:",
	"attachments": [
		{
			"fallback":  "Deployed new version of the Codeship Documentation to https://documentation.codeship.com/${CI_BRANCH}/. \n Commit <https://github.com/codeship/documentation/commit/${CI_COMMIT_ID}|${CI_COMMIT_ID:0:10}> for <https://github.com/codeship/documentation/tree/${CI_BRANCH}|${CI_BRANCH}>, view at ",
			"pretext": ":tada: there's a new version of the <https://documentation.codeship.com/${CI_BRANCH}/|docs>, please <https://documentation.codeship.com/${CI_BRANCH}/|take a look>.",
			"color": "good",
			"fields": [
				{
					"title": "Commit Message",
					"value": "${CI_COMMIT_MESSAGE}",
					"short": false
				},
				{
					"title": "Branch/Tag",
					"value": "<https://github.com/codeship/documentation/tree/${CI_BRANCH}|${CI_BRANCH}>",
					"short": true
				},
				{
					"title": "Commit Hash",
					"value": "<https://github.com/codeship/documentation/commit/${CI_COMMIT_ID}|${CI_COMMIT_ID:0:10}>",
					"short": true
				}
			]
		}
	]
}
EOT
)

# send API request to slack
log "Pinging Slack"
curl -s -X POST --data-urlencode "$payload" "$SLACK_WEBHOOK_URL"
