---
title: Using Rollbar To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With Rollbar
menus:
  pro/cd:
    title: Using Rollbar
    weight: 7
tags:
  - rollbar
  - deployment
  - logging
  - analytics
  - reports
  - reporting

---

* include a table of contents
{:toc}

## Logging Deployments With Rollbar

[Rollbar](https://www.rollbar.com) lets you collect and track errors and events related to your web applications. During your continuous deployment workflow with Codeship Pro, you can use Rollbar to log information related to your deployments.

## Setting Your Rollbar Access Token

You will need to add your Rollbar access token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

##  Logging During Deployment

Next, you will need to add the following commands to a script, placed in your repository, that you will call from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```bash
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
