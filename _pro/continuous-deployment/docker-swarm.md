---
title: Continuous Delivery With Docker Swarm
shortTitle: Deploying With Docker Swarm
menus:
  pro/cd:
    title: Docker Swarm
    weight: 15
categories:
  - Continous Deployment        
tags:
  - deployment
  - swarm
  - docker
---

<div class="info-block">
You can find a sample repository for deploying with Docker Swarm and Codeship Pro on Github [here](https://github.com/codeship-library/example-voting-app/tree/codeship-integration).
</div>

* include a table of contents
{:toc}

Deploying your application with Docker Swarm and Codeship Pro is easy. You'll just need a few things:

- A provider to host your Swarm (AWS/Google Cloud/Azure/Etc)

- A Docker Compose V3 file to orchestrate your Swarm

- Your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) and [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to run your CI/CD pipeline on Codeship Pro

## Setup

### Compose V3 and codeship-services.yml

To deploy with Docker Swarm and Codeship Pro, an important first step is clarifying the difference between your [Docker Compose V3](https://docs.docker.com/compose/compose-file/) file and your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

- The Docker Compose V3 file is intended to orchestrate your production container setup. Your Swarm deployment will rely on this file for knowing what to deploy and how to configure it.

- The [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), while very similar in syntax to a Docker Compose file, is intended to outline the containers and commands you need for your CI/CD pipeline.

### Cloud Authentication

To deploy, you will also need to be able to authenticate with your cloud infrastructure provider. We provide documentation for general authentication, as well as sample code and integration images, with the common cloud providers:

- [AWS]({{ site.baseurl }}{% link _pro/continuous-deployment/aws.md %})
- [Google Cloud]({{ site.baseurl }}{% link _pro/continuous-deployment/google-cloud.md %})
- [Azure]({{ site.baseurl }}{% link _pro/continuous-deployment/azure.md %})

If you have any specific authentication questions or need help, [contact our helpdesk](https://helpdesk.codeship.com).

## Deploying With Swarm

To deploy with Swarm, you will want to run a `docker stack deploy` command via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

The specifics of this command will depend on the specifics of your application, and we recommend reading the [Docker documentation](https://docs.docker.com) to learn more.

```yaml
- name: swarm-deploy
  service: your-app
  command: docker stack deploy --compose-file docker-stack.yml app
```

Note that this example is using a `docker` command. This will only work if the container can find a Docker host. In a normal use case, this example would be assuming that your container has already authenticated with and connected to an external resource, such as AWS or Google Cloud, where the Docker host that is expected to run these commands is available.

## Example Project

To learn more, you can [visit our sample repository](https://github.com/codeship-library/example-voting-app/tree/codeship-integration) to see a working example of using Compose V3 and Swarm to deploy to Google Cloud.
