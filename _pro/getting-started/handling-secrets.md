---
title: "Handling Secrets during Codeship Pro Builds"
layout: page
weight: 45
tags:
  - docker
  - secrets
  - encryption
  - environment
category: Getting Started
---

* include a table of contents
{:toc}

During most Codeship builds, your build machine needs to access or communicate with some resource that requires some kind of credential. 
There are two main ways to pass in secrets to the Docker containers where your build steps run: environment variables and build arguments. Codeship supports encrypted and unencrypted versions of both. Depending on how the secret is consumed, either build arguments or environment variables may be a better choice.


|                                              |Buildtime |Runtime|
|----------------------------------------------|----------|-------|
|Build arguments                               |X         |       |
|ENV declared in Dockerfile                    |X         |X      |
|Environment variables in codeship-services.yml|          |X      |

Typically, the need for passing secrets to the build falls into three main categories: interacting with private Docker registries, accessing private assets during the image build, and deployments to a remote host.

> Note: Docker advises against using build arguments to pass in any sort of secrets to your images, as they can be seen when inspecting the image layers. At Codeship, your builds run in a single-tenant environment, and no other entity has access to your build machine. Your machine (and everything on it!) is destroyed after each build. We _don't recommend_ using build arguments for secrets when building images that will live on _production_ boxes, but your single-tenant, ephemeral CI/CD build machine is a bit different.

## How do I push or pull from a private Docker image registry during a Codeship Pro build?
You can store login credentials for your Docker image registry by using an encrypted credentials file. That file is declared in the service with the `encrypted_dockercfg_path` key. With those credentials, you'll be able to pull private base images to use in your iwn Docker images, pull images from a private registry, and push your images to a private registry. Read the [tutorial on pulling private images](https://documentation.codeship.com/pro/getting-started/docker-pull/) to get started.

## How do I access private assets during a Docker image build?
In some cases, you might need to access an asset or resource that requires authentication during the Docker image build process. A few examples include private gem servers or any asset with a location that isn't static, like a path to a resource that may vary from build to build.

For values that need to be accessed at buildtime, use a build argument. Think of build args as environment variables that are only available when the image is in the process of being built (such as when you run `docker build`).  

Build arguments can be passed to the image as either encrypted or unencrypted values. Read the [tutorial on using build arguments with your Codeship services] to learn more. Using build arguments during a Codeship Pro build will also require [changes to your Dockerfile](https://docs.docker.com/engine/reference/builder/#/arg).

## How can I provide deployment credentials to Codeship?
For any secret that needs to be accessed during container runtime -- that is, during any step you've declared in the `codeship-steps.yml` file -- you should use encrypted environment variables. You can learn more about using encrypted environment variables in [this article](https://documentation.codeship.com/pro/getting-started/encryption/). You'll need to [download Jet](https://documentation.codeship.com/pro/getting-started/installation/), the CLI for running Codeship Pro builds locally, as well as grab your project's AES key from the Project Settings page.

### Have a use case that's missing from this article? Ask a question on the Codeship [community forum](https://community.codeship.com/c/docker).