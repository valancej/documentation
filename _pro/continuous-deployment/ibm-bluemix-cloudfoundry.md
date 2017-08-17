---
title: Continuous Delivery to IBM Bluemix Cloud Foundry Azure with Docker
shortTitle: Deploying To IBM Bluemix Cloud Foundry
menus:
  pro/cd:
    title: IBM Cloud Foundry
    weight: 2
tags:
  - deployment
  - ibm
  - cloud foundry
  - bluemix

---
<div class="info-block">
You can find a sample repo for deploying to IBM Bluemix with Codeship Pro on Github [here](https://github.com/codeship-library/ibm-bluemix-utilities).
</div>

* include a table of contents
{:toc}

## Continuous Delivery To IBM Bluemix Cloud Foundry

To make it easy for you to deploy your application to Azure we’ve built a container that has the AzureCLI installed. We will set up a simple example showing you how to configure any deployment to Azure.

**Note** that since Codeship Pro runs Docker containers on Linux build machines, in addition to deploying to Azure, we also support all Microsoft .NET builds that do not require Windows build machines.

## IBM Bluemix Deployment Container

## Prerequisites

Prior to getting started, please ensure you have the following installed in your local linux/unix environment.

- [An Understanding Of Codeship Pro]({% link _pro/quickstart/getting-started.md %})
- [Codeship's Jet CLI]({% link _pro/builds-and-configuration/cli.md %})
- [Docker](https://www.Docker.com/products/overview)
- [A Microsoft Azure Account](https://azure.microsoft.com/)

## Authentication

Before setting up the `codeship-services.yml` and `codeship-steps.yml` file we’re going to create an encrypted environment file that contains a service principal, password, and tenant ID.

## Deploying Your App

## See Also
