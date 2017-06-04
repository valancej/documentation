---
title: Using Rollbar To Track Deployments With Codeship Basic
layout: page
weight: 13
tags:
  - rollbar
  - deployment
  - logging

---

* include a table of contents
{:toc}

## Logging Deployments With Rollbar

[Rollbar](https://www.rollbar.com) lets you collect and track errors and events related to your web applications. During your continuous deployment workflow with Codeship Basic, you can use Rollbar to log information relate to your deployments.

## Setting Your Rollbar Access Token

You will need to add your Rollbar access token to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

##  Logging During Deployment

To send logs during deployments, you will want to add a new custom-script step to all of your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

This new step will either run the following commands, or run a script that includes the following commands:

```bash
curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$ACCESS_TOKEN \
  -F environment=$CI_BRANCH \
  -F revision=$CI_COMMIT_ID \
  -F local_username=$CI_COMMITTER_USERNAME
```
