---
title: Continuous Delivery to Google Cloud Platform with Docker
shortTitle: Deploying To Google Cloud
menus:
  pro/cd:
    title: Google Cloud
    weight: 4
tags:
  - deployment
  - google
  - google cloud
  - gcr
  - docker

redirect_from:
  - /docker-integration/google-cloud/
---

<div class="info-block">
You can find a sample repo for deploying to Google Cloud with Codeship Pro on Github [here](https://github.com/codeship-library/google-cloud-deployment).
</div>

* include a table of contents
{:toc}

## Deploying With Google Cloud

To deploy to Google Cloud services, you will need to create a container that can authenticate with your Google Account, and with the appropriate Google product, as well as run the Google Cloud CLI to execute your intended commands.

We maintain an [example repository](https://github.com/codeship-library/google-cloud-deployment) with [an image stored on Dockerhub](https://hub.docker.com/r/codeship/google-cloud-deployment/) to simplify this process. You can copy setup instructions from this repo or reuse the Dockerfile, our [turnkey Google Cloud image](https://hub.docker.com/r/codeship/google-cloud-deployment/) or our [GCR authentication generator](https://hub.docker.com/r/codeship/gcr-dockercfg-generator/) simply by adding the necessary elements from our [Google Cloud repo](https://github.com/codeship-library/google-cloud-deployment) to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

## Authentication

### Create Service Account

For authenticating with the Google Cloud Platform we're going to create a *Service account* inside your Google Cloud account management.

Go to the [GCP console](https://console.developers.google.com), select your project and go to *APIs & auth* &rarr; *Credentials*:

![Google Cloud Platform Credentials View]({{ site.baseurl }}/images/docker/credentials-link.png)

Next, click *Add credentials* and add a *Service account*. Then, select the JSON download option when prompted on the next page.

This will download a JSON file that contains credentials that you will use for authentication in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

First, you will need to provide these credentials as [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}).

### Encrypting Account Credentials

Now you will need to create a new file to store your account credentials in, in the form of environment variables. You will then [encrypt this file]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) and save it in your repository to be used during your builds.

Your new environment variables file will container the following:

```bash
GOOGLE_AUTH_JSON=...
GOOGLE_AUTH_EMAIL=...
GOOGLE_PROJECT_ID=...
```

- `GOOGLE_AUTH_JSON` should be populated with the account credential string you received in the JSON file you downloaded earlier.  **Note** that you will need to remove all newlines from the file. On Linux and macOS you can use `tr '\n' ' ' < your_file_name` to get the line and copy it back into the file.

- `GOOGLE_AUTH_EMAIL` should be populated with the account email address that you can find on the *credentials* page in the *Service accounts* section. **Note** that it has to be from the *Service account* we just created.

- `GOOGLE_PROJECT_ID` should be populated with the value found on the Dashboard of your project in the Google developer console.

<div class="alert-block">
**Be sure to put this unencrypted env file into `.gitignore` so its never committed, or delete it altogether following encryption.**
</div>

After creating this environment variables file, you will need to encrypt it using the instructions from our [encrypted environment variables tutorial]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) or by using the commands below:

```bash
jet encrypt your_env_file your_env_file.encrypted
```

 This encrypted file will be committed to your repository and used in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Authentication Commands

Before calling any commands against the GCP API you need to authenticate with the Gcloud tool using the credentials and [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) you created above.

The [deployment image that we maintain]((https://hub.docker.com/r/codeship/google-cloud-deployment/)) provides a default command named `codeship_google authenticate`. If you set up the environment variables for a service using this image, in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), it will set the configuration up for you using those account credentials.

The following example runs the `codeship_google authenticate` command and would typically be run at the start of a script file in your repository that contains all your deployment commands, called from your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):

```bash
#!/bin/bash

# Authenticate with the Google Services
codeship_google authenticate
```

Since this authentication does not persist between steps in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}), you will need to run the provided authentication command at the beginning of each step that attempts to run commands via the Google Cloud deployment container.

### Codeship Public Key

Some Google Cloud services will require that you add your [Codeship public key]({{ site.baseurl }}{% link _general/projects/project-ssh-key.md %}) for authentication purposes.

**Note** that Google may fail authentication if you do not add the Google Cloud user the key is for to the end of the key. For example, if the Google Cloud user is `deploy@Codeship`, you will want to add `deploy@Codeship` to the end of the SSH key itself, otherwise Google will not load the key for the user appropriately.

## Commands And Deployments

### Creating Your Services

You will want to add a service to build [deployment image that we maintain]((https://hub.docker.com/r/codeship/google-cloud-deployment/) in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}). For example:

```yaml
googleclouddeployment:
  image: codeship/google-cloud-deployment
  encrypted_env_file: google-credentials.encrypted
  add_docker: true
  volumes:
    - ./:/deploy
```

**Note** that this example adds your Google Cloud account credentials as encrypted environment variables and adds the repository folder as a [volume]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) at `/deploy` so that we can use it as part of the build.

### Deployment Commands

After defining your authentication variables and your deployment service, you will want to run deployment commands via your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

Because each step runs in a separate group of containers, you will likely want to bundle you Google Cloud commands together in a script file that you add to your repository and call from a step:

```yaml
- name: google-cloud-deployment
  service: googleclouddeployment
  command: google-deploy.sh
```

Inside this deployment script will be all commands you want to run via the Google Cloud or Kubernetes CLI, both included in the [deployment image that we maintain]((https://hub.docker.com/r/codeship/google-cloud-deployment/).

Here is an example deployment script that you can use as a basis for your own deployments. Note that it authenticates at the top using the command discussed earlier.

```bash
#!/bin/bash

# Authenticate with the Google Services
codeship_google authenticate

# Set the default zone to use
gcloud config set compute/zone us-central1-a

# Starting an Instance in Google Compute Engine
gcloud compute instances create testmachine

# Stopping an Instance in Google Compute Engine
gcloud compute instances delete testmachine -q
```

In this example:

- We authenticate with Google Cloud
- Then, we are setting the default zone to use
- Next, we are starting an instance in the Google Compute Engine.

As you can see, the deployment script is essentially just standard Google Cloud CLI commands - meaning, you can run any Google Cloud commands that you want.

You can also take a look at a [longer example we use for integration testing our container](https://github.com/codeship-library/google-cloud-deployment/blob/master/deployment/test/deploy_to_google.sh).

## Container Engine And Container Registry

If you are looking to use Google Container Engine and Google Container registry, we main [specific documentation]({{ site.baseurl }}{% link _pro/continuous-deployment/google-container.md %}) for using those services.
