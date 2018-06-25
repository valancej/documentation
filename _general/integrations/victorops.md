---
title: Using VictorOps To Track Deployments With Codeship Pro
shortTitle: Tracking Deployments With VictorOps
menus:
  general/integrations:
    title: Using VictorOps
    weight: 13
categories:
  - Integrations    
tags:
  - VictorOps
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
---

* include a table of contents
{:toc}

## About VictorOps

[VictorOps](https://www.victorops.com) lets you send alerts and notifications about critical events to your on-call or development team.

By using VictorOps your engineering team can respond to important alerts quickly and run your applications without concern.

[Their documentation](https://help.victorops.com) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Keys

First, you will need to add your VictorOps API key and your API ID to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

You can view [their documentation](https://help.victorops.com/knowledge-base/api/) for information on retrieving your API key and your API ID.

### Sending Incidents

Next, you will need to add [API calls to VictorOps](https://portal.victorops.com/public/api-docs.html), in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

There are a couple common ways you may do this:

- To alert of a successful deployment, as the last step in your pipelines

- Combined with your deployment commands in a script, to alert of a failed deployment.

This example will run a deployment command, and then a script that would theoretically call the relevant [VictorOps API endpoints](https://portal.victorops.com/public/api-docs.html) if that deployment is successful (meaning, if it moves on to the next step.)

```yaml
- name: deploy
  service: app
  tag: master
  command: your deployment commands here

- name: VictorOps
  service: app
  tag: master
  command: VictorOps.sh
```

Alternatively, you could combine your deployment scripts with an VictorOps API call, in a custom script that would alert VictorOps if a deployment command fails before ultimately surfacing an exit status code `1` (or or anything other than `0`) to instruct Codeship to fail to the build:

```yaml
- name: deploy
  service: app
  tag: master
  command: deploy.sh
```

The VictorOps API call itself, however implemented, will likely look similar to:

```shell
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'X-VO-Api-Id: addle' --header 'X-VO-Api-Key: lkskakld' -d 'hi' 'https://api.victorops.com/api-public/v1/incidents'
```

Although it is worth noting that [their API](https://portal.victorops.com/public/api-docs.html) provides a variety of endpoints and services you can implement.

## Codeship Basic

### Setting Your Keys

First, you will need to add your VictorOps API key and your API ID to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

You can also view [their documentation](https://help.victorops.com/knowledge-base/api/) for information on retrieving your API key and your API ID.

### Sending Incidents

Next, you will need to add [API calls to VictorOps](https://portal.victorops.com/public/api-docs.html) via a custom-script deployment added to your [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}), most likely to alert of a successful deployment or combined with your deployment commands in a script to alert of a failed deployment.

The VictorOps API call will likely look similar to:

```shell
curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'X-VO-Api-Id: addle' --header 'X-VO-Api-Key: lkskakld' -d 'hi' 'https://api.victorops.com/api-public/v1/incidents'
```

You will likely want to add the above to a script file in your repository and call that script.

It is also worth noting that [their API](https://portal.victorops.com/public/api-docs.html) provides a variety of endpoints and services you can implement.
