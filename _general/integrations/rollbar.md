---
title: Using Rollbar To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With Rollbar
menus:
  general/integrations:
    title: Using Rollbar
    weight: 3
tags:
  - rollbar
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
redirect_from:
  - /basic/continuous-deployment/rollbar-basic/
  - /pro/continuous-deployment/rollbar-docker/

---

* include a table of contents
{:toc}

## About Rollbar

[Rollbar](https://www.rollbar.com) lets you collect and track errors and events related to your web applications. During your continuous deployment workflow with Codeship Pro, you can use Rollbar to log information related to your deployments.

By using Rollbar you can track important logs for future analysis and alerting.

[Their documentation](https://rollbar.com/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Access Token

You will need to add your Rollbar access token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

###  Logging During Deployment

Next, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```shell
curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$ACCESS_TOKEN \
  -F environment=$CI_BRANCH \
  -F revision=$CI_COMMIT_ID \
  -F local_username=$CI_COMMITTER_USERNAME
```

You will need to call this script on all deployment-related branches by specifying the [tag]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}/#limiting-steps-to-specific-branches-or-tags). Be sure to add this step _after_ your deployment commands, so that it only runs if the deployments were successful. For example:

```yaml
- name: deploy
  service: app
  tag: master
  command: your deployment commands

- name: rollbar
  service: app
  tag: master
  command: deploy-rollbar.sh
```

## Codeship Basic

### Setting Your Access Token

You will need to add your Rollbar access token to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

###  Logging During Deployment

To log a deployment-related datapoint in Rollbar, you will want to add a new custom-script step to all of your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

This new step will either run the following commands, or run a script that includes the following commands:

```shell
curl https://api.rollbar.com/api/1/deploy/ -F access_token=$ACCESS_TOKEN -F environment=$CI_BRANCH -F revision=$CI_COMMIT_ID -F local_username=$CI_COMMITTER_USERNAME
```
