---
title: Integrating Codeship With Hakiri
shortTitle: Using Hakiri
tags:
  - security
  - integrations
menus:
  general/integrations:
    title: Using Hakiri
    weight: 18
---

* include a table of contents
{:toc}

## About Hakiri

[Hakiri](https://Hakiri.com) is a service for analyzing and monitoring the security of your application dependencies.

[The Hakiri documentation](https://github.com/Hakiri/toolbelt) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Setting Your Hakiri Token

You will need to add your `Hakiri_TOKEN` value to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you  encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

There are other options to configure your `.Hakiri.yml` file that you can set in your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), as well. [See the Hakiri documentation](https://github.com/Hakiri/toolbelt) for a full list.

### Installing The CLI

To use Hakiri in your CI/CD process, you'll need to add the Hakiri CLI to a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

To add the Hakiri CLI, you will need to add the following command to the Dockerfile for the service you want to run Hakiri on:


```bash
sudo apt-get install Hakiri-toolbelt
```

**Note** that this requires the Dockerfile to be using a Debian-based base image. [See the Hakiri documentation](https://github.com/Hakiri/toolbelt) for a list of alternative installation instructions.

### Running An Evaluation

Once your Hakiri token is loaded via your environment variables and you have defined a service that installs the Hakiri CLI, you can run a Hakiri evaluation during your CI/CD pipeline by passing the Hakiri CLI commands via the service you have it installed in.

We will combine the Hakiri authentication and Hakiri scan commands into a script file that we call from a step:

```bash
- name: Hakiri
  service: app
  command: Hakiri.sh
```

Inside this `Hakiri.sh` script, you will have something similar to:

```bash
Hakiri configure $Hakiri-PROJECT-ID
Hakiri eval -f=Gemfile,Gemfile.lock
```

There is a larger list of possible uses for Hakiri, and commands you can run, over at [the Hakiri documentation](https://github.com/Hakiri/toolbelt).

**Note** that the above commands will require that the `Hakiri_TOKEN` environment variable be set, as instructions earlier. They will also require passing the `Hakiri-PROJECT-ID` either directly or through an environment variable.

## Codeship Basic

### Setting Your Hakiri Token

You will need to add your `Hakiri_TOKEN` value to the your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

![Configuration of Hakiri env vars]({{ site.baseurl }}/images/continuous-integration/Hakiri-env-vars.png)

There are other options to configure your `.Hakiri.yml` file that you can set in your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}), as well. [See the Hakiri documentation](https://github.com/Hakiri/toolbelt) for a full list.

### Installing The CLI

To use Hakiri in your CI/CD process, you'll need to install the Hakiri CLI via your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```bash
go build -o Hakiri
```

### Running An Evaluation

Once your Hakiri token is loaded via your environment variables and you have installed the Hakiri CLI, you can run a Hakiri evaluation during your CI/CD pipeline.

You will need to add the following commands to your project's [setup and test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %})

```bash
Hakiri configure $Hakiri-PROJECT-ID
Hakiri eval -f=Gemfile,Gemfile.lock
```

There is a larger list of possible uses for Hakiri, and commands you can run, over at [the Hakiri documentation](https://github.com/Hakiri/toolbelt).

**Note** that the above commands will require that the `Hakiri_TOKEN` environment variable be set, as instructions earlier. They will also require passing the `Hakiri-PROJECT-ID` either directly or through an environment variable.
