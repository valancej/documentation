---
title: Docker 101 For Continuous Integration And Continuous Deployments
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

Because Codeship Pro uses Docker domain language, and is powered by Docker, most customers find it easier to use if they are familiar with Docker concepts.

While being a Docker user is not required to use Codeship Pro, the more you know about Docker the more natively you will be able to understand Codeship Pro.

## Does Codeship Pro Require Docker?

[Codeship Pro](https://codeship.com/features/pro) does not require Docker. It does, though, reuse Docker patterns - and it is powered by Docker. So, for Docker applications or teams familiar with Docker, Codeship Pro is often very familiar and easy to set up.

However, teams not using Docker can still make use of the flexibility offered by Codeship Pro, it simply requires learning key concepts we borrow from and reuse from Docker to power your CI/CD builds.

## What Is Docker?

Docker is a technology product, created by [Docker Inc.](https://www.docker.com), based on the [open-source Moby project](https://mobyproject.org). Docker is a tool to build and and run applications inside of containers based on Docker images, which is a portable and reusable file that launches an almost full-stack application environment.

For more information, [visit Docker's "What Is Docker?" page](https://www.docker.com/what-docker).

## Key Docker Concepts

If you're going to explore Docker and Codeship Pro, here are some links to the concepts that we consider a solid foundation for natively understanding Docker and Codeship Pro.

### Dockerfile

Dockerfiles are image specifications, essentially blueprints for what is inside of your images and the containers built from those images. Dockerfiles are often similar to the commands you would run locally to get an environment working: Adding your code, installing your dependencies, fetching packages, etc.

[Learn more about Dockerfiles](https://docs.docker.com/engine/reference/builder/).

### Compose/Services File

A Docker Compose file is the syntax model for our own  Codeship Services file, and they do very similar work in their respective contexts.

Docker Compose is a schema for how orchestrating and networking your containers. Compose is a product maintained by Docker, whereas our Services file is a Codeship-specific file for defining your CI/CD environment that borrows heavily from Compose syntax to define your CI/CD build environment via containers.

[Learn more about Docker Compose](https://docs.docker.com/compose/overview/).

### Images

Images environment files are built from Dockerfiles. They are saved either locally or remotely via image registries, and are used to define the specification for containers. Containers are the running instance of any specific image.

Images compile and save a fully loadable environment for your code to run in, in a standardized way. [Learn more about Docker images](https://docs.docker.com/glossary/?term=image).

### Containers

Containers are the running environments instantiated from  images. You can run containers in production or just locally. We  use them in CI/CD with Codeship Pro to let you define your own environments for your project's runtime configuration.

[Learn more about containers](https://www.docker.com/what-container).

### Volumes

Volumes are directories mounted either on the host machine or inside your containers (or both) that can share assets between containers. Volumes are a useful way to keep data separate from the container itself, so that it can store and persist outside the temporal nature of a container.

[Learn more about Docker volumes]({{ site.baseurl }}{% link _pro/builds-and-configuration/docker-volumes.md %}).

## Learn More

To learn more about how Docker, Codeship Pro and CI/CD work together we recommend [our introductory webinar](https://resources.codeship.com/webinars/thank-you-video-an-introduction-to-ci-cd-with-docker-best-practices).
