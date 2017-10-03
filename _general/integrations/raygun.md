---
title: Using Raygun To Track Errors And Deployments
shortTitle: Tracking Errors And Deployments With Raygun
menus:
  general/integrations:
    title: Using Raygun
    weight: 20
tags:
  - raygun
  - deployment
  - logging
  - analytics
  - reports
  - reporting
  - integrations
  - errors

---

* include a table of contents
{:toc}

## About Raygun

[Raygun](https://raygun.com) lets you collect and track errors and deployments for your applications.

By using Raygun you can keep track of error logs and deployment events easier.

[Their documentation](https://raygun.com/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your API Key

You will need to add your Raygun API key to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

###  Installing Raygun Dependency

Raygun maintains a list of modules that can be installed as dependencies for a wide variety of languages and frame works. You will want to [visit their documentation](https://raygun.com/docs) and follow the instructions to use the dependency that is right for your application.

This dependency will need to be installed in the Dockerfile that you build via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Sending Data

Once you have your API key and dependency installed, you will send data via API calls that you can make in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```yaml
- name: raygun
  service: app
  command: raygun.sh
```

Notice that in this case we are calling a script named `raygun.sh`. Inside this scrip, we could have a Raygun API call similar to:

```
client.send(new Error(), { 'mykey': 'beta' }, function (response){ });
```

## Codeship Basic

### Setting Your API Key

You will need to add your Raygun API key to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

###  Installing Raygun Dependency

Raygun maintains a list of modules that can be installed as dependencies for a wide variety of languages and frame works. You will want to [visit their documentation](https://raygun.com/docs) and follow the instructions to use the dependency that is right for your application.

This dependency will need to be installed in the Dockerfile that you build via your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

### Sending Data

Once you have your API key and dependency installed, you will send data via API calls that you can make in your [test or deployment commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```
client.send(new Error(), { 'mykey': 'beta' }, function (response){ });
```
