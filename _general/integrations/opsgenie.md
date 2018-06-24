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
categories:
  - Integrations  
---

* include a table of contents
{:toc}

## About OpsGenie

[OpsGenie](https://www.opsgenie.com) lets you send alerts and notifications about critical events to your on-call or development team.

By using OpsGenie your engineering team can respond to important alerts quickly and run your applications without concern.

[Their documentation](https://www.opsgenie.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Webhook Method

The simplest way to integrate OpsGenie with Codeship is to use the webhook integration. From inside your OpsGenie account, you will first want to enable the [Codeship integration](https://app.opsgenie.com/integration#/add/Codeship).

Once the Codeship integration is enabled in OpsGenie, you will want to create a [custom webhook in your project's notifications]({{ site.baseurl }}{% link _general/account/notifications.md %}#webhook) using the webhook destination URL provided by the integrations page in OpsGenie.

All successful Codeship builds will now complete with a webhook to OpsGenie to trigger your configured alerts.

### Manual Integration

For a more granular implementation, where you can choose exactly what to trigger on OpsGenie and when, you can manually integrate the OpsGenie API into your pipeline.

#### Setting Your API Key

First, you will need to add your OpsGenie API key to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

#### Sending Alerts

Next, you will need to add [API calls to OpsGenie](https://www.opsgenie.com/docs/rest-api/alert-api), in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

There are a couple common ways you may do this:

- To alert of a successful deployment, as the last step in your pipelines

- Combined with your deployment commands in a script, to alert of a failed deployment.

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

The OpsGenie API call itself, however implemented, will likely look similar to:

```shell
curl -XPOST 'https://api.opsgenie.com/v1/json/alert' -d '
{
    "apiKey": "YOUR_API_KEY",
    "message" : "Deployment Failed",
    "teams" : ["ops", "managers"]
}'
```

Although it is worth noting that [their API](https://www.opsgenie.com/docs) provides a variety of endpoints and services you can implement.

## Codeship Basic

### Webhook Method

The simplest way to integrate OpsGenie with Codeship is to use the webhook integration. From inside your OpsGenie account, you will first want to enable the [Codeship integration](https://app.opsgenie.com/integration#/add/Codeship).

Once the Codeship integration is enabled in OpsGenie, you will want to create a [custom webhook in your project's notifications]({{ site.baseurl }}{% link _general/account/notifications.md %}#webhook) using the webhook destination URL provided by the integrations page in OpsGenie.

All successful Codeship builds will now complete with a webhook to OpsGenie to trigger your configured alerts.

### Manual Integration

For a more granular implementation, where you can choose exactly what to trigger on OpsGenie and when, you can manually integrate the OpsGenie API into your pipeline.

#### Setting Your API Key

First, you will need to add your OpsGenie API key to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

#### Sending Alerts

Next, you will need to add [API calls to OpsGenie](https://www.opsgenie.com/docs/rest-api/alert-api) via a custom-script deployment added to your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}), most likely to alert of a successful deployment or combined with your deployment commands in a script to alert of a failed deployment.

The OpsGenie API call will likely look similar to:

```shell
curl -XPOST 'https://api.opsgenie.com/v1/json/alert' -d '
{
    "apiKey": "YOUR_API_KEY",
    "message" : "Deployment Failed",
    "teams" : ["ops", "managers"]
}'
```

Although it is worth noting that [their API](https://www.opsgenie.com/docs) provides a variety of endpoints and services you can implement.
