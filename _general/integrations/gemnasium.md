---
title: Integrating Codeship With Gemnasium
shortTitle: Using Gemnasium
tags:
  - security
  - integrations
menus:
  general/integrations:
    title: Using Gemnasium
    weight: 17
---

* include a table of contents
{:toc}

## About Gemnasium

[Gemnasium](https://gemnasium.com) is a service for analyzing and monitoring the security of your application dependencies.

[The Gemnasium documentation](https://github.com/gemnasium/toolbelt) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Gemnasium Token

You will need to add your `GEMNASIUM_TOKEN` value to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you  encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

There are other options to configure your `.gemnasium.yml` file that you can set in your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), as well. [See the Gemnasium documentation](https://github.com/gemnasium/toolbelt) for a full list.

### Installing The CLI

To use Gemnasium in your CI/CD process, you'll need to add the Gemnasium CLI to a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

To add the Gemnasium CLI, you will need to add the following command to the Dockerfile for the service you want to run Gemnasium on:


```bash
sudo apt-get install gemnasium-toolbelt
```

**Note** that this requires the Dockerfile to be using a Debian-based base image. [See the Gemnasium documentation](https://github.com/gemnasium/toolbelt) for a list of alternative installation instructions.

### Running An Evaluation

Once your Gemnasium token is loaded via your environment variables and you have defined a service that installs the Gemnasium CLI, you can run a Gemnasium evaluation during your CI/CD pipeline by passing the Gemnasium CLI commands via the service you have it installed in.

We will combine the Gemnasium authentication and Gemnasium scan commands into a script file that we call from a step:

```bash
- name: Gemnasium
  service: app
  command: gemnasium.sh
```

Inside this `gemnasium.sh` script, you will have something similar to:

```bash
gemnasium configure $GEMNASIUM-PROJECT-ID
gemnasium eval -f=Gemfile,Gemfile.lock
```

There is a larger list of possible uses for Gemnasium, and commands you can run, over at [the Gemnasium documentation](https://github.com/gemnasium/toolbelt).

**Note** that the above commands will require that the `GEMNASIUM_TOKEN` environment variable be set, as instructions earlier. They will also require passing the `GEMNASIUM-PROJECT-ID` either directly or through an environment variable.

## Codeship Basic

### Setting Your Gemnasium Token

You will need to add your `GEMNASIUM_TOKEN` value to the your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

![Configuration of Gemnasium env vars]({{ site.baseurl }}/images/continuous-integration/Gemnasium-env-vars.png)

There are other options to configure your `.gemnasium.yml` file that you can set in your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}), as well. [See the Gemnasium documentation](https://github.com/gemnasium/toolbelt) for a full list.

### Installing The CLI

To use Gemnasium in your CI/CD process, you'll need to install the Gemnasium CLI via your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
go build -o gemnasium
```

### Running An Evaluation

Once your Gemnasium token is loaded via your environment variables and you have installed the Gemnasium CLI, you can run a Gemnasium evaluation during your CI/CD pipeline.

You will need to add the following commands to your project's [setup and test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %})

```bash
gemnasium configure $GEMNASIUM-PROJECT-ID
gemnasium eval -f=Gemfile,Gemfile.lock
```

There is a larger list of possible uses for Gemnasium, and commands you can run, over at [the Gemnasium documentation](https://github.com/gemnasium/toolbelt).

**Note** that the above commands will require that the `GEMNASIUM_TOKEN` environment variable be set, as instructions earlier. They will also require passing the `GEMNASIUM-PROJECT-ID` either directly or through an environment variable.
