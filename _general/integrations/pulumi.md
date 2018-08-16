---
title: Integrating Codeship With Pulumi
shortTitle: Using Pulumi In CI/CD
tags:
  - integrations
  - orchestration
  - containers
categories:
  - Integrations
menus:
  general/integrations:
    title: Using Pulumi
    weight: 25
---

* include a table of contents
{:toc}

## About Pulumi

{% csnote info %}
Pulumi only integrates with [Codeship Pro](https://codeship.com/features/pro) and will not work with [Codeship Basic](https://codeship.com/features/basic).

If you do not have a familiarity with Codeship Pro, we recommend watching this [introductory webinar](https://resources.codeship.com/webinars/env-parity-docker-codeship-jet) before proceeding with your Pulumi setup.
{% endcsnote %}

Pulumi is a platform for defining cloud applications and infrastructure, making configuration and deployment fast and easy.

[Their documentation](https://Pulumi.com/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Using Pulumi

We will not cover Pulumi-side setup for your application in this documentation article, but if you are looking for more information on using Pulumi itself you can learn more from [their documentation](https://Pulumi.com/docs/).

Note that this guide has an easy to use [sample repo](https://github.com/pulumi/codeship-example) that you can clone and follow along with, with more examples than this documentation covers.

## Adding Pulumi Keys

To start, you need to add your `PULUMI_ACCESS_TOKEN`, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

You will add these encrypted environment variables to the service you create below for executing your Pulumi commands.

## Defining Your Service

Because all the commands in your pipeline, via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}), are executed inside the service you define and build build via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) - the first thing you will need to do is define a service that is capable of executing Pulumi commands.

To do this, you can create a Dockerfile that looks similar to the one below:

```dockerfile
FROM node:8

# Install Pulumi
RUN curl -sSL https://get.pulumi.com/ | bash -s -- --version 0.14.2

# Add Pulumi to the $PATH
ENV PATH="/root/.pulumi/bin:${PATH}"

# Install docker
RUN apt-get update && \
    apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common && \
     curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

# Copy over the package.json and yarn.lock files and then install packages. By copying just these two files first
# we get better docker caching behavior (as these layers only change with you add or remove dependencies, not when)
# you do normal application development.
COPY package.json yarn.lock ./
RUN yarn install

COPY . .
```

Once you have a image capable of executing Pulumi Compose commands, you will want to build that image via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```yaml
app:
  build:
    dockerfile: Dockerfile
  encrypted_env_file: env.encrypted
  add_docker: true
```

Note that the service that will execute our Pulumi commands is using the encrypted environment variables created earlier in this documentation for our secrets.

## Deploying With Pulumi

After creating your keys and defining a service to execute your Pulumi commands, you will now want to add those commands to your pipeline via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```yaml
- service: app
  command: /app/deploy.sh update
```

Note that in this example, we're calling a script named `deploy.sh` with the `update` argument. Inside this script, we will see something similar to:

```
#!/bin/bash
set -eou pipefail

pulumi ${1:-preview} --stack pulumi/codeship-example-${CI_BRANCH} --non-interactive "${@:2}"
```

With this script, you will be able to pass any specific Pulumi command that you need to run. The important thing is that the `service` directive is pointing to the service defined via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) with the necessary tooling installed.

For more examples, check out the [Pulumi sample repo])https://github.com/pulumi/codeship-example).
