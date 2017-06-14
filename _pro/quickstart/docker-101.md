---
title: Docker For CI/CD
layout: page
menus:
  pro/quickstart:
    title: Docker For CI/CD
    weight: 7
tags:
  - docker
  - jet
  - introduction
  - getting started

---

* include a table of contents
{:toc}

## What Is Docker?

You may be hearing about Docker because you're trying out Codeship Pro, or you may be trying out Codeship Pro because you're hearing about Docker. Either way, we will look at some of the key information required to understand and evaluate both Docker and Codeship Pro.

Docker is a technology product, created by [Docker Inc.](https://www.docker.com), based on the [open-source Moby project](https://mobyproject.org). Docker is a tool to build and and run applications inside of containers build from Docker images, which is a portable and reusable file that launches an almost full-stack application environment.

Docker is helpful for making code environment-agnostic, easier to jump into and less tied to specific OS and infrastructure requirements.

## What Is Codeship Pro?

[Codeship Pro](https://codeship.com/features/pro) is a CI/CD product, similar to [Codeship Basic](https://codeship.com/features/basic). In both cases, it is a way to automate the testing and deploying of your code based on your Git-based source control repository.

Codeship Pro differs from Codeship Basic in a few key ways:

- Codeship Pro uses Docker containers to build a custom build environment, granting you almost full control over the build configuration for your CI/CD projects.

- Codeship Pro natively supports Docker apps, and support non-Docker apps through easy to set up Docker containers.

- While Codeship Basic uses turnkey, preconfigured environments, Codeship Pro is optimized for customizability, flexibility and more control for more complex needs.

## Do I Need To Use Docker or Codeship Pro?

Whether or not you need to use Docker or Codeship Pro comes down to a few questions your team can ask internally:

- Do you have problems that Docker specifically would solve, such as difficulty setting up new environments, slow onboarding for developers or issues keeping environments at parity?

- Do you have custom CI/CD workflow needs that require custom environment configuration, complex timing or pipeline structuring, dedicated resource allocation or greater use of advanced tooling like Terraform, Chef, Puppet, or Ansible (to name just a few)?

In either of these cases a Docker and Codeship Pro workflow likely makes sense. If the answer to both is no, it may be worth exploring Codeship Basic instead.

## Key Docker Concepts

If you're going to explore Docker and Codeship Pro, there are some basic concepts that are worth taking a few moments to learn.


- **Dockerfiles** are image specifications, essentially blueprints for what is inside of your images and the containers built from those images. Dockerfiles are often similar to the commands you would run locally to get an environment working: Adding your code, installing your dependencies, fetching packages, etc. [Learn more about Dockerfiles](https://docs.docker.com/engine/reference/builder/).

- **Compose/Services file**, alternatively called a Docker Compose file or a Codeship Services file, is a schema for how to orchestrate your containers to build the environment. Compose is a product maintained by Docker, whereas a Services file is a Codeship-specific file for defining your CI/CD environment that borrows heavily from Compose syntax. [Learn more about codeship-services.yml]({{ site.baseurl }}{% link _pro/builds-and-configuration/service.md %}).

- **Images** are built from Dockerfiles. They are saved locally and remotely, via image registries, and are used to orchestrate containers. Images compile and save a fully loadable environment for your code to run in, in a standardized way. [Learn more about Docker images](https://docs.docker.com/engine/reference/commandline/images/).

- **Containers** are the actually running environments launched from Docker images. You can run containers in product, or just locally. We  use them in CI/CD with Codeship Pro to let you define your own environments for your project's runtime configuration. [Learn more about containers](https://www.docker.com/what-container).

- **Volumes** are directories mounted either on the host machine or inside your containers (or both) that can share assets between containers. Volumes are a useful way to keep data separate from the container itself, so that it can store and persist outside the temporal nature of a container. [Learn more about Docker volumes]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}).

## Learn More

To learn more about how Docker, Codeship Pro and CI/CD work together we recommend [our introductory webinar](https://resources.codeship.com/webinars/thank-you-video-an-introduction-to-ci-cd-with-docker-best-practices).
