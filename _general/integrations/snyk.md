---
title: Integrating Codeship With Snyk For Security Analysis
shortTitle: Using Snyk For Security Analysis
tags:
  - security
  - reports
  - reporting
  - integrations
menus:
  general/integrations:
    title: Using Snyk
    weight: 16
categories:
  - Integrations    
---

* include a table of contents
{:toc}

## About Snyk

[Snyk](https://snyk.io) is an automated way to check for security vulnerabilities with your dependencies.

By using Snyk you can be sure that your dependencies are up to date and secure.

Starting with Snyk and Codeship is fast and easy. The [Snyk documentation](https://snyk.io/docs) does a great job of providing more information, in addition to the setup instructions below.

## Codeship Pro

### Adding Token

To start, you need to add your `SNYK_TOKEN` to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### CLI Configuration

To use Snyk in your CI/CD process, you'll need to add the Snyk CLI to a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

To add the Snyk CLI, you will need to add the following command to the Dockerfile for the service you want to run Snyk on:


```dockerfile
RUN npm install -g snyk
```

**Note** that this requires the Dockerfile to also have Node and NPM available, to use the Snyk CLI.

### Running A Scan

Once your Snyk token is loaded via your environment variables and you have defined a service that installs the Snyk CLI, you can run a Snyk scan during your CI/CD pipeline by passing the Snyk CLI commands via the service you have it installed in.

We will combine the Snyk authentication and Snyk scan commands into a script file that we call from a step:

```yaml
- name: Snyk
  service: app
  command: snyk.sh
```

Inside this `snyk.sh` script, you will have something similar to:

```shell
snyk auth
snyk test
```

**Note** that the above `snyk auth` command will use the `SNYK_TOKEN` environment variable you set earlier for authentication.

## Codeship Basic

### Adding Token

To start, you need to add your `SNYK_TOKEN` to your to your project's [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}).

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### CLI Configuration

To use Snyk in your CI/CD process, you'll need to install the Snyk CLI via your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}):

```shell
npm install -g snyk
```

### Running A Scan

Once your Snyk token is loaded via your environment variables and you have installed the Snyk CLI, you can run a Snyk scan during your CI/CD pipeline.

You will need to add the following commands to your project's [setup and test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %})

```shell
snyk auth
snyk test
```

**Note** that the above `snyk auth` command will use the `SNYK_TOKEN` environment variable you set earlier for authentication.
