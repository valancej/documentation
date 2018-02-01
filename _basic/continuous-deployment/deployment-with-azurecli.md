---
title: Deployment With Azure CLI
menus:
  basic/cd:
    title: Azure CLI
    weight: 10
tags:
  - deployment
  - azure
  - cli
  - microsoft
categories:
  - Continuous Deployment    
---

* include a table of contents
{:toc}

## Azure Deployments

Deployments to [Azure](https://azure.microsoft.com/en-us) can be done using the Azure CLI directly on a Codeship Basic build machine similar to how you might use the CLI locally.

You will need to install the CLI, configure your authentication with environment variables and then define the CLI commands you want to run as a [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

### Installing The CLI

The [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/overview?view=azure-cli-latest) _does not_ come pre-installed on Codeship Basic build machines.

Please add the following command in the [Setup Commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) section of your test settings to install the Azure CLI:

```shell
pip install azure-cli
```

### Configuring Authentication

Once the CLI is installed, you will need to run the appropriate Azure [login commands](https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest#command-line) in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}#configuring-your-setup-commands) or at the start of your [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}).

The easiest way to keep the authentication secure is to use [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) to store the username and password, and to pass those to your Azure login commands.

### Deployment Scripting

You will need to create a new [custom-script deployment pipeline]({{ site.baseurl }}{% link _basic/continuous-deployment/deployment-with-custom-scripts.md %}) to run the Azure CLI commands you need for your deployment.

These commands will run every time the branch the deployment pipeline is associated with is updated. They are not Codeship specific and will be standard Azure CLI input.

## Azure CLI Information

Read more about the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/overview?view=azure-cli-latest) for more information on using the CLI as well as complete documentation on what commands can be run with it.
