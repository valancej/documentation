---
title: Services Configuration
layout: page
weight: 56
tags:
  - docker
  - jet
  - configuration
  - services
category: Getting Started
redirect_from:
  - /docker/services/
---

* include a table of contents
{:toc}

## What Is Your Codeship Services File?
Your services files - `codeship-services.yml` - is the [Docker Compose](https://docs.docker.com/compose/) based file your CI/CD process with Codeship relies on to build and orchestrate your environment. At the start of every new build, we create a new build instance, with Docker installed, to run your build on. From there, what containers are built and when is defined by your [codeship-steps.yml]({% link _docker/getting-started/steps.md %}) file running commands on the individual containers defined in your `codeship-services.yml` file.

Your `codeship-services.yml` file, just like Docker Compose, can build images out of Dockerfiles or fetch images from image registries. These image registries can be public or you can provide  credentials to pull (and push) images to private registries as part of your CI/CD process.

Some great examples of how and why we based `codeship-services.yml` on Docker Compose:

* Set up different environments for running your unit, integration or acceptance tests to keep containers small and startup times fast.
* Build specialized deployment containers to unify deployment across your company
* Use any Docker container available on an image registry for your builds
* Easily switch between different versions of databases or build your own container for a special database
* Have full control over every piece of Software in the build

**Note**: There are a few Docker Compose features not yet supported by `codeship-services.yml`. We will eventually be at full Docker Compose parity, but until then you can use most features of Docker Compose in your `codeship-services.yml` file with little to no modification. For a list of non-supporter Docker Compose features, see below in this article.

## Prerequisites
Your Services file will require that you have [installed Jet locally]({{ site.baseurl }}{% link _docker/getting-started/cli.md %}) or [set up your project on Codeship.]({{ site.baseurl }}{% link _docker/getting-started/codeship-configuration.md %})

## Services File Setup & Configuration
By default, we look for the filename `codeship-services.yml` but a `docker-compose.yml` file that does not include any non-support functionality will also be automatically recognized and used if no `codeship-services.yml` is present. Compose commands that we do not yet fully support will usually be ignored, although occasionally they can also trigger errors.

Your services file is structured identically to a standard [Docker Compose](https://docs.docker.com/compose/) file with the exception of the unavailable features listed in this article.

### Build Directive
The basic `build` directive, to build containers and images out of your Dockerfile, is fully supported. You [specify a build](https://docs.docker.com/compose/compose-file/#build) in the same way as is standard with Docker Compose, although you can also use an extended version as needed. You can also mix formats between services, but not for a single service - i.e. you can build some of your services from one or more Dockerfiles while other services simply download existing images from registries.

```yaml
app:
  build:
    image: codeship/app
    path: app
    dockerfile_path: Dockerfile
data:
  image: busybox
```

* `image` specifies the output image name, as opposed to generating one by default.

* `path` sets the build context, essentially defining a custom root directory for any ADD or COPY directives (as well as specifying where to look for the Dockerfile). It's important to note that the _Dockerfile_ is searched for relative to that directory. If you don't specify a custom `path`, it will default to the directory of the services file.

* `dockerfile_path` allows you to specify a specific Dockerfile to use, rather than inheriting one from the build context. It does not, however, change the build context or override the root directory.

### Volumes
You can use `volumes` in your `codeship-services.yml` file to persist data between containers as well as between steps in your CI/CD process.

An example setup using volumes in your `codeship-services.yml` file would look like this:

```
```yaml
app:
  build:
    image: codeship/app
    dockerfile_path: Dockerfile
  volumes_from:
    - data
data:
  image: busybox
  volumes:
    - ./tmp/data:/data
```

[Learn more about using volumes.]({{ site.baseurl }}{% link _docker/getting-started/docker-volumes.md %})

### Environment Variables
The standard `environment` and `env_file` directives are supported. Additionally, we support encrypted environment variables with `encrypted_environment` and `encrypted_env_file` directives. These are the same format, except they expect encrypted variables.

An example setup explicitly declaring your environment variables in your `codeship-services.yml` file would look like this:

```
app:
  build:
    image: codeship/app
    dockerfile_path: Dockerfile
  environment:
    ENV: string
    ENV2: string
```

An example setup providing your encrypted environment variable file in your `codeship-services.yml` file would look like this:

```
app:
  build:
    image: codeship/app
    dockerfile_path: Dockerfile
  encrypted_env_file: env.encrypted
```

The way we encrypt our environment variables is by creating a file in our root directory - in this case, a file named `env` and then [downloading our project AES key.]({{ site.baseurl }}{% link _docker/getting-started/encryption.md %}) to root directory (and adding it to our `.gitignore` file.)

Once the AES key is in our directory, we can run the `jet encrypt` command with an *input* and an *output* filename: `jet encrypt env env.encrypted` ([Learn more about using Jet]({{ site.baseurl }}{% link _docker/getting-started/installation.md %}))

Lastly, we would either delete the unencrypted `env` file or add it to our `.gitignore`.

[Learn more about encrypting your environment variables.]({{ site.baseurl }}{% link _docker/getting-started/encryption.md %})

### Docker Inside Docker
The boolean directive `add_docker` is available. If specified for a service, it will:

* Add the environment variables `DOCKER_HOST`, `DOCKER_TLS_VERIFY` and `DOCKER_CERT_PATH` from the host.
* If `DOCKER_CERT_PATH` is set, it will mount the certificate directory through to the container.
See [add_docker](https://github.com/codeship/codeship-tool-examples/tree/master/14.add_docker) for an example using [Docker-in-Docker](https://registry.hub.docker.com/u/jpetazzo/dind).

### Caching the Docker image
Caching is declared per service. For a service with caching enabled, Codeship will store your image remotely in an encrypted S3 bucket, and then use that image to repopulate the local build cache on future build runs. This prevents the Docker image from building from scratch each time, to save time and speed up your CI/CD process. By default, we will fall back to the latest image that was built on the `master` branch.

An example setup using caching in your `codeship-services.yml` file would look like this:

```yml
app:
  build:
    image: codeship/app
    dockerfile_path: Dockerfile
  cached: true
```

There are several specific requirements and considerations when using caching, so it is recommended that you [read our caching documentation.]({{ site.baseurl }}{% link _docker/getting-started/caching.md %}) before enabling caching on your builds.

## Unavailable Features
The following features available from Docker Compose are not available on Codeship.

* Support for version headings, like `version: "2"`
* Support for network configuration
* Support for build arguments
* Support for the following directives
  * `depends_on`
  * `cpu_quota`
  * `stop_signal`
  * `extends`
  * `labels`

All linking to the host is not allowed. This means the following directives are excluded:
  * `external_links`
  * `ports`
  * `stdin_open`

## More Resources
* [Docker Compose](https://docs.docker.com/compose/)
* [Build Directive In Compose](https://docs.docker.com/compose/compose-file/#build)
* [Encrypting environment variables.]({{ site.baseurl }}{% link _docker/getting-started/encryption.md %})
* [Steps File]({% link _docker/getting-started/steps.md %})
* [Volumes]({{ site.baseurl }}{% link _docker/getting-started/docker-volumes.md %})
* [Add_Docker Directive in Compose](https://github.com/codeship/codeship-tool-examples/tree/master/14.add_docker)
* [Docker-in-Docker](https://registry.hub.docker.com/u/jpetazzo/dind).
* [Caching]({{ site.baseurl }}{% link _docker/getting-started/caching.md %})

## Other Notes
* `link` containers will be newly created for each step.
* `volumes_from` containers will be created exactly once for all services.

## Questions
If you have any specific questions, you can submit a ticket to the the help desk or post on the [community forum](https://community.codeship.com).
