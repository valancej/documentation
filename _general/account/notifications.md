---
title: Build Notifications
layout: page
tags:
  - administration
  - notifications

redirect_from:
  - /administration/notifications/
  - /basic/getting-started/webhooks/
  - /integrations/webhooks/
weight: 2
---

* include a table of contents
{:toc}

## Configuring Build Notifications

To configure build notifications, go to your *Project Settings* and then click into the **Notifications** tab.

## Email notification

By default anyone who either owns a project or was added as a team member will receive an email whenever a build fails and if a build on a branch passes when the previous one failed. Therefore, whenever a branch is back to OK you will be notified.

### Disable Email

If you don't want to receive any emails you can set that on your [account page](https://www.codeship.com/user/edit).

### Receive emails when I am involved

In your project's notification settings you can set the option that you only receive an email when the build was on the master branch or if you started this build.

## Notification Integrations

You will get notifications whenever a build starts and finishes. All information about the result and a link to it will be in the message.

We have support for the following chat notification systems. Currently you can't customize the messages sent by Codeship.

* Hipchat
* Slack
* Flowdock
* Grove.io
* Campfire

* include a table of contents
{:toc}

## Status Badges On Your Repo

If you want to add a badge showing your last builds status to your ReadMe, you can find the code in the **Notification** settings of your project.

![Codeship Status for codeship/documentation](https://codeship.com/projects/0bdb0440-3af5-0133-00ea-0ebda3a33bf6/status?branch=master)

The raw URL for the image looks like the this:

```
https://codeship.com/projects/YOUR_PROJECT_UUID/status?branch=master
```

The UUID for a specific project is available on the **General** tab in your project settings)

## Shipscope - Chrome Extension

Monitor your Codeship projects and builds with [Shipscope](https://chrome.google.com/webstore/detail/shipscope/jdedmgopefelimgjceagffkeeiknclhh). Shipscope lists all of your Codeship projects and presents the status of recent builds in the Chrome toolbar. You can restart a build or go straight to the build details on the Codeship service.

The Shipscope notifications presented by Chrome will end up in the Notification Center. If you would like to prevent Shipscope notifications in the Notification Center, simply:

1. Click the bell icon in the lower right corner of your computer screen (on Windows) or the upper right of your computer screen (on Mac) to open the Notifications Center.

2. In the Notifications Center, click the gear icon  on the bottom right corner (on Windows) or the upper right corner (on Mac).

3. Uncheck the box next to "Shipscope".

Shipscope is open source and lives on [GitHub](https://github.com/codeship/shipscope).

## Webhooks For Custom Notifications

Go to the _Notification_ settings of your project and enter the HTTP endpoint of the service you want to notify.

![Webhooks]({{site.baseurl}}/images/integrations/webhooks.png)

### Webhooks Payload

We send you a POST request containing the following build data

```json
{
  "build": {
    "build_url":"https://www.codeship.com/projects/10213/builds/973711",
    "commit_url":"https://github.com/codeship/docs/
                  commit/96943dc5269634c211b6fbb18896ecdcbd40a047",
    "project_id":10213,
    "build_id":973711,
    "status":"testing",
    # PROJECT_FULL_NAME IS DEPRECATED AND WILL BE REMOVED IN THE FUTURE
    "project_full_name":"codeship/docs",
    "project_name":"codeship/docs",
    "commit_id":"96943dc5269634c211b6fbb18896ecdcbd40a047",
    "short_commit_id":"96943",
    "message":"Merge pull request #34 from codeship/feature/shallow-clone",
    "committer":"beanieboi",
    "branch":"master"
  }
}
```

The _status_ field can have one of the following values:

- `testing` for newly started build
- `error` for failed builds
- `success` for passed builds
- `stopped` for stopped builds
- `waiting` for waiting builds
- `ignored` for builds ignored because the account is over the monthly build limit
- `blocked` for builds blocked because of excessive resource consumption
- `infrastructure_failure` for builds which failed because of an internal error on the build VM

### Custom Notifications With Codeship Pro

Due to Codeship Pro's unique architecture, you have  more flexibility in implementing custom notifications via your [codeship-steps.yml file]({% link _pro/builds-and-configuration/steps.md %}).

In addition to using the above webhooks method, you can also define custom steps in your build pipeline to push notifications via methods not otherwise supported by Codeship.

#### The notification script

To look at using your Codeship Pro pipeline for flexible, custom notifications we will review a simple Slack script as a custom notification method.

First of all, we can create a simple notification script, pulling all configuration and credentials from environment variables, or mounted volumes should we need to use build artifacts.

```bash
#!/bin/sh
# Post to Slack channel on new deployment
# https://api.slack.com/incoming-webhooks
#
# You can either add those here, or configure them on the environment tab of your
# project settings.
SLACK_WEBHOOK_TOKEN=${SLACK_WEBHOOK_TOKEN:?'You need to configure the SLACK_WEBHOOK_TOKEN environment variable!'}
SLACK_BOT_NAME=${SLACK_BOT_NAME:="Codeship Bot"}
SLACK_ICON_URL=${SLACK_ICON_URL:="https://d1089v03p3mzyq.cloudfront.net/assets/website/logo-dark-90f893a2645c98929b358b2f93fa614b.png"}
SLACK_MESSAGE=${SLACK_MESSAGE:?"${CI_COMMITTER_USERNAME} just deployed version ${CI_COMMIT_ID}"}

curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"username": "'"${SLACK_BOT_NAME}"'",
  "text": "'"${SLACK_MESSAGE}"'",
  "icon_url": "'"${SLACK_ICON_URL}"'"}' \
  https://hooks.slack.com/services/$SLACK_WEBHOOK_TOKEN
```

#### Integrating the notification script

It's quite simple to integrate a simple script like this into the deployment pipeline. First we can build it into a standalone container, or use an existing one from elsewhere in the pipeline which has the deploy script added to it.

```
# Dockerfile.notify
FROM ubuntu

RUN apt-get install -y curl

ADD ./slack ./
```

We'll need to provide this container with the necessary environment variables. The standard `CI_*` variables will be provided automatically, however we'll need to provide the `SLACK_WEBHOOK_TOKEN`. This can be safely injected via the `encrypted_env_file` service declaration, and the [encryption commands]({{ site.baseurl }}{% link _pro/builds-and-configuration/cli.md %}#encryption-commands). By encrypting this environment variable, and adding it to our repository, it can be later decoded and provided to our notifications container.

```yaml
deploynotify
  build:
    image: myuser/myrepo-deploynotify
    dockerfile: Dockerfile.notify
  encrypted_env_file: deploy.env.encrypted
```

By adding a relevant step to the steps file, we can control under what conditions this notification fires.

```yaml
- service: deploynotify
  command: ./slack
  tag: master
```

#### Other integrations

Since you can integrate any container you wish into your pipeline, there are no limitations on what notifications you can use. You can see some other examples of custom notifications [here](https://github.com/codeship/scripts/tree/master/notifications).

## GitHub, Bitbucket and Gitlab Status API

We will automatically use the status API for pull requests on Github, Bitbucket and Gitlab. This does not need to be explicitly enabled, although it can be disabled via your *Project Settings*.
