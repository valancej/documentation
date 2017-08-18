---
title: Continuous Delivery to IBM Bluemix Cloud Foundry with Docker
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

To make it easy for you to deploy your application to IBM Bluemix Cloud Foundry, we’ve [built a container](https://github.com/codeship-library/ibm-bluemix-utilities) that has the Bluemix CLI installed and that you can use for your IBM-based deployments.

## IBM Bluemix Deployment Container

## Prerequisites

Prior to getting started, please ensure you have the following:

- [An Understanding Of Codeship Pro]({% link _pro/quickstart/getting-started.md %})
- [Codeship's Jet CLI]({% link _pro/builds-and-configuration/cli.md %}) installed locally
- [Docker](https://www.Docker.com/products/overview)
- [An IBM Bluemix Account](https://www.ibm.com/cloud-computing/bluemix/)
- An understanding of using IBM Bluemix Cloud Foundry and the required manifest and database files for a Cloud Foundry application

## Authentication

To deploy to IBM, you will need to add the following values to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

- IBM_API_KEY
- IBM_API_REGION

// WIP

## Configuring Deployment Service

Once you have created your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), you will want to add a new service to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

This file will use the image Codeship maintain's for IBM-based deployments, and will read your code from a volume connected to your primary service. This service will be used for all of your Cloud Foundry deployment commands, and will use the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) you created above.

```yaml
app:
  build:
    image: your-org/your-app
    path: .
    dockerfile_path: Dockerfile.app
  encrypted_env_file: ibm.env.encrypted
  volumes: .:.

ibm:
  build:
    image: codeship/ibm-bluemix-base
    path: .
    dockerfile_path: Dockerfile.ibm
  encrypted_env_file: ibm.env.encrypted
  volumes: .:.  
```

// WIP

## Deploying Your App

Once you have added the deployment service to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), you will now run Cloud Foundry deployment commands from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```yaml
- name: deployment
  service: ibm
  command: cf push
```

// WIP

## See Also

To learn more:

- [Visit the IBM Bluemix Cloud Foundry documentation](https://console.bluemix.net/docs/)

- [View our sample app](https://github.com/codeship-library/ibm-bluemix-utilities)
