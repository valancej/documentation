---
title: Deploy To Google App Engine
menus:
  basic/cd:
    title: Google App Engine
    weight: 8
tags:
  - deployment
  - google app engine
  - gae
  - google
categories:
  - Continuous Deployment   
  - Deployment
  - Google
redirect_from:
  - /continuous-deployment/deployment-to-google-app-engine/
  - /tutorials/continuous-deployment-google-app-engine-github-django-python/
---

Codeship makes it easy to deploy your application to Google App Engine using Codeship's integrated [deployment pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}).

We support deploying projects in the following stacks: go, java, node, php, python, and ruby. Note that for java, you need to set an optional flag (see below for details).

* include a table of contents
{:toc}

## Setup Google App Engine Deployment

### Step 1 - Google Cloud Service Account

Before getting into actually configuring Codeship to deploy your code, you should create a dedicated `Service Account`. Service accounts are like users, but meant for system integrations and usually have very limited permissions.
Since we just need to deploy your code, and not have access to anything else on your project, we suggest you create a new service account specifically for Codeship, but you could also reuse an existing one if you're comfortable with that.

#### Creating Service Account

First thing is to navigate to the `AIM & admin` section and locate the `Service accounts` menu.
![Navigate to service account]({{ site.baseurl }}/images/continuous-deployment/gae_service_account_nav.png)

In that view, click the `Create Service Account` button and give the account a name, e.g. `codeship-deploy` so you can easily remember what it's for. Also ensure you check the box for "Furnish a new private key" and leave the option on `JSON`.

The last thing needed is to specify the permissions needed for the service account to be able to deploy to app engine. The only one we need is `App Engine` -> `App Engine Deployer`.

![Create service account]({{ site.baseurl }}/images/continuous-deployment/gae_create_service_account.png)

That's it. Once you save the new service account a key file will be generated and automatically downloaded to your computer.

<div class="info-block">
The key file is very important to keep safe as it provides the keys to pushing deployments to your project. Treat it like any other password, and keep it in a safe place.
</div>

### Step 2 - Navigate to Deployment Configuration

With the service account key file in place, navigate to your project's deployment configuration page by selecting _Project Settings_ on the top right side of the project page, and then the _Deploy_ option in the secondary navigation.

### Step 3 - Add New Deployment Pipeline

Edit an existing deployment pipeline or create a new deployment pipeline by selecting + _Add new deployment pipeline_. If you create a new deployment pipeline, you need to select when it's triggered. You can either match the exact name of a branch or a specify a [wildcard branch]({{ site.baseurl }}{% link _basic/builds-and-configuration/deployment-pipelines.md %}#wildcard-branch-deployment-pipelines).

![Create branch deploy]({{ site.baseurl }}/images/continuous-deployment/create_deploy_branch.png)

### Step 4 - Google App Engine
Now we're ready to configure your app engine deployment.

Select the _Google App Engine_ template from the list of available deploy templates.

![Select GAE]({{ site.baseurl }}/images/continuous-deployment/select_gae.png)

### Step 5 - Deployment Configuration

Next step is to provide the project ID as well as the keys file you downloaded in step 1.

#### Project ID

Copy-paste the project ID of the project you want the pipeline to deploy to.

#### Key File

This is the file you generated in step 1. The file includes private keys etc. that will allow us to connect to Google App Engine on your behalf, with the permissions specified for the service account.

![Configure GAE]({{ site.baseurl }}/images/continuous-deployment/configure_gae.png)

### Success!

![GAE Success]({{ site.baseurl }}/images/continuous-deployment/gae_success.png)

You have now successfully setup deployment to Google App Engine. Go ahead and push a commit to your configured deploy branch.
