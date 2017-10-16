---
title: Using PagerDuty To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With PagerDuty
menus:
  general/integrations:
    title: Using PagerDuty
    weight: 12
tags:
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

## About PagerDuty

[PagerDuty](https://www.pagerduty.com) lets you send alerts and notifications about critical events to your on-call or development team.

By using PagerDuty your engineering team can respond to important alerts quickly and run your applications without concern.

[The PagerDuty documentation](https://v2.developer.pagerduty.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Token

First, you will need to add your PagerDuty API token to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

You will need to provide this API token in your request headers. The [PagerDuty authentication documentation](https://v2.developer.pagerduty.com/docs/authentication) provided language-specific examples for this authentication.

### Sending Events

Next, you will need to add [API calls to PagerDuty](https://v2.developer.pagerduty.com/docs/send-an-event-events-api-v2), in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

There are a couple common ways you may do this:

- To alert of a successful deployment, as the last step in your pipelines

- Combined with your deployment commands in a script, to alert of a failed deployment.

You will want to add the PagerDuty API calls to a new script file in your repository and call that via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) using the service you defined for authenticating with PagerDuty:

```yaml
- name: pagerduty-alert
  service: your-app
  command: pagerduty.sh
```

Below is an example API call from PagerDuty that you can use as the basis for your own PagerDuty API calls:

```json
/*
  This example shows how to send a trigger event without a dedup_key.
  In this case, PagerDuty will automatically assign a random and unique key
  and return it in the response object.
  You should store this key in case you want to send an acknowledge or resolve
  event to this incident in the future.
*/

{
  "payload": {
    "summary": "Example alert on host1.example.com",
    "timestamp": "2015-07-17T08:42:58.315+0000",
    "source": "minotoriringtool:cloudvendor:central-region-dc-01:852559987:cluster/api-stats-prod-003",
    "severity": "info",
    "component": "postgres",
    "group": "prod-datapipe",
    "class": "deploy",
    "custom_details": {
      "ping time": "1500ms",
      "load avg": 0.75
    }
  },
  "routing_key": "samplekeyhere",
  "dedup_key": "samplekeyhere",
  "images": [{
  	"src": "https://www.pagerduty.com/wp-content/uploads/2016/05/pagerduty-logo-green.png",
  	"href": "https://example.com/",
  	"alt": "Example text"
  }
  	],
  "event_action": "trigger",
  "client": "Sample Monitoring Service",
  "client_url": "https://monitoring.example.com"
}
```

[The PagerDuty documentation](https://v2.developer.pagerduty.com/docs) provided more specifics on writing your API calls.

You can also use the [tag directive]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}#limiting-steps-to-specific-branches-or-tags) to make sure that PagerDuty alerts are only fired on certain branches, such as `master`, related to deployments:

```yaml
- name: pagerduty-alert
  tag: master
  service: your-app
  command: pagerduty.sh
```

## Codeship Basic

### Setting Your API Token

First, you will need to add your PagerDuty API token to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

You will need to provide this API token in your request headers. The [PagerDuty authentication documentation](https://v2.developer.pagerduty.com/docs/authentication) provided language-specific examples for this authentication.

### Sending Events

Next, you will need to add [API calls to PagerDuty](https://v2.developer.pagerduty.com/docs/send-an-event-events-api-v2) via a custom-script deployment added to your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}), most likely to alert of a successful deployment or combined with your deployment commands in a script to alert of a failed deployment.

Below is an example API call from PagerDuty that you can use as the basis for your own PagerDuty API calls. Note that you likely want to put your API call in a new script file in your repository that you call via your custom-script [deployment pipeline]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

```json
/*
  This example shows how to send a trigger event without a dedup_key.
  In this case, PagerDuty will automatically assign a random and unique key
  and return it in the response object.
  You should store this key in case you want to send an acknowledge or resolve
  event to this incident in the future.
*/

{
  "payload": {
    "summary": "Example alert on host1.example.com",
    "timestamp": "2015-07-17T08:42:58.315+0000",
    "source": "minotoriringtool:cloudvendor:central-region-dc-01:852559987:cluster/api-stats-prod-003",
    "severity": "info",
    "component": "postgres",
    "group": "prod-datapipe",
    "class": "deploy",
    "custom_details": {
      "ping time": "1500ms",
      "load avg": 0.75
    }
  },
  "routing_key": "samplekeyhere",
  "dedup_key": "samplekeyhere",
  "images": [{
  	"src": "https://www.pagerduty.com/wp-content/uploads/2016/05/pagerduty-logo-green.png",
  	"href": "https://example.com/",
  	"alt": "Example text"
  }
  	],
  "event_action": "trigger",
  "client": "Sample Monitoring Service",
  "client_url": "https://monitoring.example.com"
}
```

[The PagerDuty documentation](https://v2.developer.pagerduty.com/docs) provided more specifics on writing your API calls.
