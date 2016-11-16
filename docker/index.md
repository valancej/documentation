---
layout: page
collection: docker
redirect_from:
  - /docker/introduction/
---

Welcome to Codeship's Docker Infrastructure, the new way to run your tests on Codeship. Enjoy full customizability. Easily mirror your Development, Test and Production Environments with full parity. The underlying build infrastructure, based on Docker, allows for customized definition of the running environment.

<div class="info-block">
Codeship's Docker based infrastructure is available to customers on a invite only basis at the moment. Please see the [Docker feature page](http://pages.codeship.com/docker) for information and to request access.

**Note**
- Codeship's Docker Infrastructure supports git based repositories on GitHub and BitBucket. **Mercurial based repositories on BitBucket are not currently supported.**
</div>

_Docker Infrastructure_ implements two main functions:

- It replicates and replaces some of the functionality of [Docker Compose](https://docs.docker.com/compose/) for the purpose of defining the build environment.
- It allows you to define your CI and CD steps and run those the same way locally in your development environment as within the hosted Codeship environment.

For this reason we introduce two new concepts.

- [Services]({% link _docker/getting-started/services.md %}) specify a Docker image, plus accompanying configuration, same as you would do with _Docker Compose_. The Docker image defines the operating environment.
- [Steps]({% link _docker/getting-started/steps.md %}) specify what to run on those services.

To get started, please [install Jet]({{ site.baseurl }}{% link _docker/getting-started/installation.md %}) locally on your development machine and follow the [tutorial]({{ site.baseurl }}{% link _docker/getting-started/getting-started.md %}) to get your first project working on the Codeship Docker Infrastructure.
