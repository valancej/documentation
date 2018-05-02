---
title: Deployment With gcloud CLI
menus:
  basic/cd:
    title: gcloud CLI
    weight: 9
tags:
  - deployment
  - gcloud
  - gae
  - gce
  - app engine
  - compute engine
  - cli
  - google
categories:
  - Deployment
  - Google  
---

* include a table of contents
{:toc}

## Google Cloud Deployments

Deployments to [Google Cloud](https://cloud.google.com) can be done using the gcloud CLI directly on a Codeship Basic build machine similar to how you might use the CLI locally.

You will need to configure your authentication with environment variables and then define the CLI commands you want to run as a [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

### Installing The CLI

The [gcloud CLI](https://cloud.google.com/sdk/gcloud) is pre-installed on Codeship Basic build machines.

If you want to update to the latest version at build time, add the following command in the [Setup Commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) section of your test settings:

```shell
gcloud components update --quiet
```

### Configuring Authentication

Before you can run gcloud commands, you will need to run the appropriate gcloud [authentication commands](https://cloud.google.com/sdk/gcloud/reference/auth) in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) or at the start of your [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

Google recommends using a [service account](https://cloud.google.com/storage/docs/authentication#service_accounts) for authentication. The easiest way to keep the authentication secure is to use [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) to store the .json key file, and to pass that to your gcloud authentication commands.

As an example, create an environment variable called `GOOGLE_KEY` and paste the entire contents of your [.json key file](https://cloud.google.com/storage/docs/authentication#service_accounts) into it. Then in your deployment steps add the following to [authenticate with the service account](https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account):

```shell
echo "${GOOGLE_KEY}" > "$HOME/clone/google-key.json"
gcloud auth activate-service-account --key-file="$HOME/clone/google-key.json"
```

### Deployment Scripting

You will need to create a new [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}) to run the gcloud CLI commands you need for your deployment.

These commands will run every time the branch the deployment pipeline is associated with is updated. They are not Codeship specific and will be standard gcloud CLI input.

## gcloud CLI Information

Read more about the [gcloud CLI](https://cloud.google.com/sdk/gcloud) for more information on using the CLI as well as complete documentation on what commands can be run with it.
