---
title: Integrating Codeship With Hakiri
shortTitle: Using Hakiri
tags:
  - security
  - integrations
  - rails
  - ruby
menus:
  general/integrations:
    title: Using Hakiri
    weight: 18
---

* include a table of contents
{:toc}

## About Hakiri

[Hakiri](https://hakiri.io) is a service for analyzing and monitoring the security of your Rails application dependencies.

[The Hakiri documentation](https://hakiri.io/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Hakiri Stack ID

You will need to add your `STACK_ID` value to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you  encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

To generate your stack ID, you can follow [the Hakiri documentation](https://hakiri.io/docs/authentication-token).

### Manifest File

You will need a Hakiri manifest file to exist in your repo, unless you want to generate a new one each time you run your CI/CD process.

To generate the manifest file (either in CI/CD or locally so that you can commit it to your repository), you will need to follow the instructions below to install the [Hakiri Toolbelt](https://github.com/hakirisec/hakiri_toolbelt) and then run the following command:

```bash
hakiri manifest:generate
```

### Installing The Hakiri Toolbelt

To use Hakiri in your CI/CD process, you'll need to add the [Hakiri Toolbelt](https://github.com/hakirisec/hakiri_toolbelt) to a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

To install the Hakiri Toolbelt, you will need to add the following command to the Dockerfile for the service you want to run Hakiri on:


```bash
gem install hakiri
```

**Note** that this requires the Dockerfile to also have Ruby and the `gems` binary installed.

### Running A Scan

Once your Hakiri Stack ID is loaded via your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) and you have defined a service that installs the Hakiri Toolbelt, you can run a Hakiri scan during your CI/CD pipeline by passing the [Hakiri Toolbelt](https://github.com/hakirisec/hakiri_toolbelt) commands via the service you have it installed in.

For example:

```bash
- name: Hakiri
  service: app
  command: hakiri.sh
```

Inside this `hakiri.sh` script, you will have something similar to:

```bash
hakiri system:scan
hakiri system:sync -s $STACK_ID
```

There is a larger list of commands you can run over at [the Hakiri documentation](https://hakiri.io/docs).

## Codeship Basic

### Setting Your Hakiri Stack ID

You will need to add your `STACK_ID` value to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

To generate your stack ID, you can follow [the Hakiri documentation](https://hakiri.io/docs/authentication-token).

### Manifest File

You will need a Hakiri manifest file to exist in your repo, unless you want to generate a new one each time you run your CI/CD process.

To generate the manifest file (either in CI/CD or locally so that you can commit it to your repository), you will need to follow the instructions below to install the [Hakiri Toolbelt](https://github.com/hakirisec/hakiri_toolbelt) and then run the following command:

```bash
hakiri manifest:generate
```

### Installing The Hakiri Toolbelt

To use Hakiri in your CI/CD process, you'll need to install the [Hakiri Toolbelt](https://github.com/hakirisec/hakiri_toolbelt) via your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

```bash
gem install hakiri
```

### Running A Scan

Once your Hakiri Stack ID is loaded via your environment variables and you have installed the Hakiri Toolbelt, you can run a Hakiri scan during your CI/CD pipeline.

You will need to add the following commands to your project's [setup and test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

For example:

```bash
hakiri system:scan
hakiri system:sync -s $STACK_ID
```

There is a larger list of commands you can run over at [the Hakiri documentation](https://hakiri.io/docs).
