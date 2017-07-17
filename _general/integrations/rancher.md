---
title: Integrating Codeship With Rancher for Container Orchestration
shortTitle: Using Rancher For Container Orchestration
tags:
  - integrations
  - orchestration
  - containers
menus:
  general/integrations:
    title: Using Rancher
    weight: 10
---

* include a table of contents
{:toc}

## About Racher

<div class="info-block">
Note that Rancher only integrates with [Codeship Pro](https://codeship.com/features/pro) and will not work with [Codeship Basic](https://codeship.com/features/basic).

If you do not have a familiarity with Codeship Pro, we recommend watching this [introductory webinar](https://resources.codeship.com/webinars/env-parity-docker-codeship-jet) before proceeding with your Rancher setup.
</div>

Rancher is a container management platform that helps bridge the gap between container stacks and infrastructure platforms. [Their documentation](http://rancher.com/docs/) does a great job of providing more information, in addition to the setup instructions below.

## Using Rancher

We will not cover Rancher-side setup for your application in this documentation article, but if you are looking for more information on using Rancher itself we have a comprehensive [post on our blog](https://blog.codeship.com/deploying-rancher-using-codeship-pro/)

You can also learn more from [their documentation](http://rancher.com/docs/).

## Adding Rancher Keys

To start, you need to add your `RANCHER_URL`, `RANCHER_ACCESS_KEY` and `RANCHER_SECRET_KEY` to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

You will add these encrypted environment variables to the service you create below for executing your Rancher commands.

## Defining Your Service

Because all the commands in your pipeline, via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}), are executed inside the service you define and build build via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) - the first thing you will need to do is define a service that is capable of executing Rancher commands (and, specifically Rancher Compose commands.)

You can use an [existing image with Rancher compose configured](https://hub.docker.com/r/bfosberry/rancher-compose/) or build your own with a Dockerfile that looks similar to the one below:

```bash
FROM debian:8.1

ENV RANCHER_COMPOSE_VERSION v0.12.0

RUN apt-get update -q \
	&& apt-get install -y -q --no-install-recommends curl ca-certificates tar wget \
	&& wget -O /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz "https://github.com/rancher/rancher-compose/releases/download/${RANCHER_COMPOSE_VERSION}/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz" \
	&& tar -xf /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz -C /tmp \
	&& mv /tmp/rancher-compose-${RANCHER_COMPOSE_VERSION}/rancher-compose /usr/local/bin/rancher-compose \
	&& rm -R /tmp/rancher-compose-linux-amd64-${RANCHER_COMPOSE_VERSION}.tar.gz /tmp/rancher-compose-${RANCHER_COMPOSE_VERSION}\
	&& chmod +x /usr/local/bin/rancher-compose \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false

WORKDIR /app
ENTRYPOINT ["/usr/local/bin/rancher-compose"]
CMD ["--version"]
```

Once you have a image capable of executing Rancher Compose commands, you will want to build that image via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

```bash
rancher:
  build:
    image: your_org/your_image
    dockerfile: Dockerfile
  encrypted_env_file: rancher.env.encrypted
```

Note that the service that will execute our Rancher Compose commands is using the encrypted environment variables created earlier in this documentation.

## Deploying With Rancher

After creating your encrypted Rancher keys and defining a service to execute your Rancher Compose commands, you will now want to add those commands to your pipeline via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```bash
- name: rancher-deploy
  service: rancher
  command: "rancher-compose  --p YOUR_STACK_NAME --verbose up -d --force-upgrade --pull --confirm-upgrade YOUR_SERVICE_NAME"
 ```

 Note that this specific Rancher Compose command can be substituted for any command you need to run. The important thing is that the `service` directive is pointing to the service defined via your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) with the Rancher Compose packages installed.

 If you have multiple Rancher commands to run, you can combine them in a script file and execute that rather than running a command directly:

 ```
 - name: rancher-deploy
   service: rancher
   command: deploy.sh
 ```

 You will just need to add the required script to your repository and to the containers in your pipeline.
