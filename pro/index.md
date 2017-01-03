---
title: Codeship Pro
layout: page
collection: pro
redirect_from:
  - /docker/introduction/
  - /docker/getting-started/
---
Welcome to Codeship Pro, the most customizable way to run your tests on Codeship. Easily mirror your development, test and production environments with full parity. The underlying build infrastructure, based on Docker, allows for customized definition of each service and dependency you require.

Your Codeship Pro builds run on infrastucture equipped with version {{ site.data.docker.version }} of the Docker Engine.

<div class="info-block">
**Note** Codeship Pro supports git-based repositories on GitHub, GitLab, and Bitbucket. Mercurial-based repositories on Bitbucket are not currently supported.**
</div>

_Codeship Pro_ implements two main functions:

- It replicates and replaces some of the functionality of [Docker Compose](https://docs.docker.com/compose/) for the purpose of defining the build environment.
- It allows you to define your CI and CD steps and run those the same way locally in your development environment as within the hosted Codeship environment.

For this reason we introduce two new concepts.

- [Services]({% link _pro/getting-started/services.md %}) specify a Docker image, plus accompanying configuration, same as you would do with _Docker Compose_. The Docker image defines the operating environment.
- [Steps]({% link _pro/getting-started/steps.md %}) specify what to run on those services.

To get started, please [install Jet]({{ site.baseurl }}{% link _pro/getting-started/installation.md %}) locally on your development machine and follow the [tutorial]({{ site.baseurl }}{% link _pro/getting-started/getting-started.md %}) to get your first project working on the Codeship Pro.
