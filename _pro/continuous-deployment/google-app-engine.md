---
title: Continuous Delivery to Google App Engine
shortTitle: Deploying To Google App Engine
menus:
  pro/cd:
    title: Google App Engine
    weight: 5
tags:
  - deployment
  - google
  - google cloud
  - google app engine
  - app engine
---

* include a table of contents
{:toc}

## Deploying To Google App Engine

Follow these steps to deploy your application to [Google App Engine](https://cloud.google.com/appengine/).

### Authentication

Deploying your application to App Engine via the `gcloud` utility only involves a couple of commands. Please follow the steps for [creating a Google Cloud service account](#authentication) and encrypting the provided credentials. Those are required to authenticate with Google Cloud during the deployment phase.

### Deployment Service

You will want to add a service which references the [Google Cloud deployment image]((https://hub.docker.com/r/codeship/google-cloud-deployment/), which is maintained by Codeship, in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}). For example:

```yaml
googleclouddeployment:
  image: codeship/google-cloud-deployment
  encrypted_env_file: google-credentials.encrypted
  add_docker: true
  volumes:
    - ./:/deploy
```

**Note** that this example adds your Google Cloud account credentials as encrypted environment variables and mounts the repository as a [volume]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) to the `/deploy` folder inside the container so that it is usable as part of the build.

### Deployment Step

Add the following snippet to your `codeship-steps.yml` file, referencing the service we added earlier and calling a `google-deploy.sh` script which will deploy your application to Google App Engine.

```yaml
- name: google-cloud-deployment
  service: googleclouddeployment
  command: google-deploy.sh
```

Following is a very basic version of an App Engine deployment script. You can customize the script to fit your specific needs, e.g. by specifying custom configuration files that will drive the deployment instead of the default `app.yml`. Save this script as `google-deploy.sh` to the root of your repository.

```bash
#!/bin/bash

# Authenticate with the Google Services
codeship_google authenticate

# switch to the directory containing your app.yml (or similar) configuration file
# note that your repository is mounted as a volume to the /deploy directory
cd /deploy/

# deploy the application
gcloud app deploy
```

Please see the [documentation for `gcloud app deploy`](https://cloud.google.com/sdk/gcloud/reference/app/deploy) on which options are available and how they affect the deployment.

Google also publishes stack and language specific tutorials for deploying to App Engine via their documentation, detailing more advanced options. See their [App Engine documentation](https://cloud.google.com/appengine/docs/) for specific articles on deploying [Ruby](https://cloud.google.com/appengine/docs/flexible/ruby/testing-and-deploying-your-app), [Node.js](https://cloud.google.com/appengine/docs/flexible/nodejs/testing-and-deploying-your-app) or [PHP](https://cloud.google.com/appengine/docs/flexible/php/testing-and-deploying-your-app) based applications (among others).
