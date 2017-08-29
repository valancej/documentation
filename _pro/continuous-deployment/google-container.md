---
title: Continuous Delivery to Google Container Engine and Google Container Registry with Docker
shortTitle: Deploying To Google Container Engine
menus:
  pro/cd:
    title: Google Container Engine
    weight: 11
tags:
  - deployment
  - google
  - google cloud
  - gcr
  - docker
---

<div class="info-block">
You can find a sample repo for deploying to Google Cloud with Codeship Pro on Github [here](https://github.com/codeship-library/google-cloud-deployment).
</div>

* include a table of contents
{:toc}

## Google Container Engine

To deploy to Google Container Engine and Google Container Registry, you will need to create a container that can authenticate with your Google Account and another to generate authentication for pushing and pulling images to and from Google Container Registry.

We maintain an [example repository](https://github.com/codeship-library/google-cloud-deployment) with [a deployment image stored on Dockerhub](https://hub.docker.com/r/codeship/google-cloud-deployment/) to simplify this process. We also maintain a [GCR authentication generator image](https://hub.docker.com/r/codeship/gcr-dockercfg-generator/). You can add these images and examples to your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) to get started quickly.

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

<div class="alert alert-warning">
  <p class="alert-txt">
    Be sure to put this unencrypted env file into `.gitignore` so its never committed, or delete it altogether following encryption.
  </p>
</div>

After creating this environment variables file, you will need to encrypt it using the instructions from our [encrypted environment variables tutorial]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) or by using the commands below:

```bash
jet encrypt your_env_file your_env_file.encrypted
```

 This encrypted file will be committed to your repository and used in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Codeship Public Key

Some Google Cloud services will require that you add your [Codeship public key]({{ site.baseurl }}{% link _general/projects/project-ssh-key.md %}) for authentication purposes.

**Note** that Google may fail authentication if you do not add the Google Cloud user the key is for to the end of the key. For example, if the Google Cloud user is `deploy@Codeship`, you will want to add `deploy@Codeship` to the end of the SSH key itself, otherwise Google will not load the key for the user appropriately.

## Pushes And Deployments

### Creating Your Services

First you will define all of your required services. If you are using the Google Container Registry, this will include the [GCR authentication generator image](https://hub.docker.com/r/codeship/gcr-dockercfg-generator/) and if you are using Google Container Engine it will also include the [deployment image we maintain](https://hub.docker.com/r/codeship/google-cloud-deployment/).

These will be added as new services in your  [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

```yaml
gcr_dockercfg:
  image: codeship/gcr-dockercfg-generator
  add_docker: true
  encrypted_env_file: google-credentials.encrypted

googleclouddeployment:
  image: codeship/google-cloud-deployment
  encrypted_env_file: google-credentials.encrypted
  add_docker: true
  volumes:
    - ./:/deploy
```

**Note** that this example adds your Google Cloud account credentials as encrypted environment variables and adds the repository folder as a [volume]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}) at `/deploy` so that we can use it as part of the build.

### Pushing To GCR

Next, you will reference the `gcr_dockercfg` service from the above example using the `dockercfg_service` option in a [push step]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}) to GCR specific in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}).

```yaml
- service: app
  type: push
  image_name: gcr.io/company_name/container_name
  registry: https://gcr.io
  dockercfg_service: gcr_dockercfg
```

### Using Container Engine

After your [push step]({{ site.baseurl }}{% link _pro/builds-and-configuration/image-registries.md %}) to GCR specific in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}) to GCR, you may want to run Google Container Engine commands next in your pipeline.

This will be done using the `googleclouddeployment` service from our above example [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %})..

```yaml
- service: app
  type: push
  image_name: gcr.io/company_name/container_name
  registry: https://gcr.io
  dockercfg_service: gcr_dockercfg

# Set up script that interacts with Gcloud after the container push
- name: google-container-engine-deployment
  service: googleclouddeployment
  command: google-deploy.sh
```

This is calling `google-deploy.sh`, which would be a file in your repository that you add all your necessary Google Container Engine commands to - or any other Google Cloud commands that you need to run.

Here is an is an example `google-deploy.sh` that you could use to base your own Google Container Engine scripts off of. Note that this is using Kubernetes as well as Google Container Engine:

```bash
#!/bin/bash

set -e

GOOGLE_CONTAINER_NAME=gcr.io/codeship-production/google-deployment-example
KUBERNETES_APP_NAME=google-deployment
DEFAULT_ZONE=us-central1-a

codeship_google authenticate

echo "Setting default timezone $DEFAULT_ZONE"
gcloud config set compute/zone $DEFAULT_ZONE

echo "Starting Cluster on GCE for $KUBERNETES_APP_NAME"
gcloud container clusters create $KUBERNETES_APP_NAME \
    --num-nodes 1 \
    --machine-type g1-small

echo "Deploying image on GCE"
kubectl run $KUBERNETES_APP_NAME --image=$GOOGLE_CONTAINER_NAME --port=8080

echo "Exposing a port on GCE"
kubectl expose rc $KUBERNETES_APP_NAME --create-external-load-balancer=true

echo "Waiting for services to boot"

echo "Listing services on GCE"
kubectl get services $KUBERNETES_APP_NAME

echo "Removing service $KUBERNETES_APP_NAME"
kubectl delete services $KUBERNETES_APP_NAME

echo "Waiting After Remove"

echo "Stopping port forwarding for $KUBERNETES_APP_NAME"
kubectl stop rc $KUBERNETES_APP_NAME

echo "Stopping Container Cluster for $KUBERNETES_APP_NAME"
gcloud container clusters delete $KUBERNETES_APP_NAME -q
```

## Other Google Cloud Services

If you are looking to use other Google Cloud services, we maintain [specific documentation]({{ site.baseurl }}{% link _pro/continuous-deployment/google-cloud.md %}) for using the Google Cloud CLI for all other deployments.
