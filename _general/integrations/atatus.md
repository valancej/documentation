---
title: Using Atatus To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With Atatus
menus:
  general/integrations:
    title: Using Atatus
    weight: 3
tags:
  - atatus
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
  - errors
  - performance
categories:
  - Integrations
redirect_from:
  - /basic/continuous-deployment/atatus-basic/
  - /pro/continuous-deployment/atatus-docker/

---

* include a table of contents
{:toc}

## About Atatus

[Atatus](https://www.atatus.com) lets you monitor performance and track errors related to your web and back-end applications in real-time. During your continuous deployment workflow with Codeship Pro, you can record your deployments in Atatus.

By using Atatus, you can compare performance metrics and errors with previous deployment.

[Their documentation](https://www.atatus.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Admin API Key

You will need to add your Atatus admin api key to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

###  Logging During Deployment

Next, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

In this case we are calling a script named `deploy-atatus.sh`.

```shell
curl https://api.atatus.com/api/deployments \
  -F admin_api_key=$ADMIN_API_KEY \
  -F revision=$CI_COMMIT_ID \
  -F release_stage=$CI_BRANCH \
  -F user=$CI_COMMITTER_USERNAME \
  -F changes="$DEPLOYMENT_NOTES"
```

You will need to call this script on all deployment-related branches by specifying the [tag]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}/#limiting-steps-to-specific-branches-or-tags). Be sure to add this step _after_ your deployment commands, so that it only runs if the deployments were successful. For example:

```yaml
- name: deploy
  service: app
  tag: master
  command: your deployment commands

- name: atatus
  service: app
  tag: master
  command: deploy-atatus.sh
```

## Codeship Basic

### Setting Your Admin API Key

You will need to add your Atatus admin api key to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

###  Logging During Deployment

To log a deployment-related datapoint in Atatus, you will want to add a new custom-script step to all of your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

This new step will either run the following commands, or run a script that includes the following commands:

```shell
curl https://api.atatus.com/api/deployments \
  -F admin_api_key=$ADMIN_API_KEY \
  -F revision=$CI_COMMIT_ID \
  -F release_stage=$CI_BRANCH \
  -F user=$CI_COMMITTER_USERNAME \
  -F changes="$DEPLOYMENT_NOTES"
```
