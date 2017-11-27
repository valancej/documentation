---
title: Continuous Delivery to Azure Container Service
shortTitle: Deploying To Azure Container Service
menus:
  pro/cd:
    title: Azure Container Service
    weight: 7
categories:
  - Continuous Deployment   
tags:
  - aks
  - Kubernetes
  - deployment
  - azure
  - microsoft
  - Docker

---
<div class="info-block">
You can find a sample repo for deploying to the Azure Container Service with Codeship Pro on Github [here](https://github.com/codeship-library/azure-utilities).
</div>

* include a table of contents
{:toc}

## Continuous Delivery To Azure Container Service

To make it easy for you to deploy your application to Azure Container Service, we’ve [built deployment images](https://github.com/codeship-library/azure-utilities) that have the Azure Container Service installed and configured for use in the CI/CD process.

You will simply need to add one of the Azure deployment images as a service in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) so that you can run the commands you need.

## Azure Deployment Container

### Prerequisites

Prior to getting started, please ensure you have the following:

- [An Understanding Of Codeship Pro]({% link _pro/quickstart/getting-started.md %})
- [Codeship's Jet CLI]({% link _pro/builds-and-configuration/cli.md %}) installed locally
- [Docker](https://www.Docker.com/products/overview)
- [An Azure Container Serviceaccount ](https://azure.microsoft.com/account/)
- An understanding of using Azure Container Service

### Authentication

To deploy to the Azure Container Service, you will need to add the following values to your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}):

- `AZURE_USERNAME` - Your username of the Admin user of the registry
- `AZURE_PASSWORD` - The password associated with the above admin user
- `AZURE_REGISTRY` - The URL of the registry you want to access (in the form of NAME.azurecr.io)

These variables will be set on the [Azure deployment container](https://github.com/codeship-library/azure-utilities), which you can read more about below. This deployment container will use the environment variables as part of the authentication required by the Azure Container Service when you run your deployment commands.

### Configuring Deployment Service

Once you have created your [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}), you will want to add a new service to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

This file will use [the image Codeship maintains](https://github.com/codeship-library/azure-utilities) for Azure-based deployments, and will read your code from a volume connected to your primary service.

This service will be used for all of your Azure Container Service deployment commands, and will use the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) you created above.

```yaml
app:
  build:
    image: your-org/your-app
    path: .
    dockerfile_path: Dockerfile.app
  encrypted_env_file: env.encrypted
  volumes:
    - ./:/code

azure_dockercfg:
  image: codeship/azure-dockercfg-generator
  add_docker: true
  encrypted_env_file: azure.env.encrypted

azure_deployment:
  image: codeship/azure-deployment
  encrypted_env_file: azure.env.encrypted  
  volumes_from:
    - app
```

## Container Registry

Using Azure Container Service usually involves pushing images to the Azure Container Service as part of your CI/CD process.

We recommend reading [our guide for pushing to the IBM Cloud container registry]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}#azure-container-service), as the deployment commands below will feature an image push based on those instructions.

## Deploying Your App

Once you have added the deployment service to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), you will now run Azure Container Service deployment commands from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) using that service to execute the commands.

Note that in this example, all of the Container Service deployment commands have been moved to a script file named `deploy_to_azure.sh`.

```yaml
- name: Push To The Azure Container Service Registry
  service: app
  type: push
  tag: master
  image_name: codeship.azurecr.io/codeship-testing
  registry: codeship.azurecr.io
  dockercfg_service: azure_dockercfg

- name: Azure Container Service Deployment
  service: azure_deployment
  command: deploy_to_azure.sh
```

Inside the `deploy_to_azure.sh` script, you will have something similar to the commands below:

```shell
COMMANDS TBD
```

## See Also

To learn more:

- [Visit the Azure Container Service documentation](https://docs.microsoft.com/en-us/azure/aks/)

- [View our example repository](https://github.com/codeship-library/azure-utilities)
