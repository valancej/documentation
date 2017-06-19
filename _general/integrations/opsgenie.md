---
title: Using OpsGenie To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With OpsGenie
menus:
  general/integrations:
    title: Using OpsGenie
    weight: 6
tags:
  - opsgenie
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
---

* include a table of contents
{:toc}

## About OpsGenie

[OpsGenie](https://www.opsgenie.com) lets send alerts and notifications about critical events to your on-call or development team.

[Their documentation](https://www.opsgenie.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Key

You will need to add your OpsGenie API key to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Sending Alerts

Next, you will need to add [API calls to OpsGenie](https://www.opsgenie.com/docs/rest-api/alert-api), in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}), most likely to alert of a successful deployment or combined with your deployment commands in a script to alert of a failed deployment.

This example will run a deployment command, and then a script that would theoretically call the relevant [OpsGenie API endpoints](https://www.opsgenie.com/docs/rest-api/alert-api) if that deployment is successful (meaning, if it moves on to the next step.)

```yaml
- name: deploy
  service: app
  tag: master
  command: your deployment commands here

- name: opsgenie
  service: app
  tag: master
  command: opsgenie.sh
```

Alternatively, you could combine your deployment scripts with an OpsGenie API call, in a custom script that would alert OpsGenie if a deployment command fails before ultimately surfacing an exit status code `1` (or or anything other than `0`) to instruct Codeship to fail to the build:

```yaml
- name: deploy
  service: app
  tag: master
  command: deploy.sh
```

## Codeship Basic

### Setting Your API Key

You will need to add your OpsGenie API key to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Sending Alerts

Next, you will need to add [API calls to OpsGenie](https://www.opsgenie.com/docs/rest-api/alert-api) via a custom-script deployment added to your [[deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}), most likely to alert of a successful deployment or combined with your deployment commands in a script to alert of a failed deployment.
