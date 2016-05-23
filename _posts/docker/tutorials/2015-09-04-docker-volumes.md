---
title: "Tutorial: Docker volumes"
layout: page
weight: 45
tags:
  - docker
  - tutorial
categories:
  - docker
---

* include a table of contents
{:toc}

<div class="info-block">
To follow this tutorial on your own computer, please [install the `jet` CLI locally first]({{ site.baseurl }}{% post_url docker/jet/2015-05-25-installation %}).
</div>

## What Are Docker Volumes?
Volumes are a way to pass data between containers, as well as between steps in your CI/CD process. Volumes are directories that other containers can read data from once they have been mounted either inside of one of your containers or on the host infrastructure itself.

This means you can have containers that work together without needing to tightly couple them or build out any direct communication between them. This is a great way to keep your containers efficient, and volumes solve a lot of problems in Docker-based architecture.

## Using Docker Volumes With Codeship
There are two primary ways to use Docker volumes in your CI/CD process with Codeship.

### Passing Data Between Containers
You can mount volumes in your containers and allow other containers to access that volume *during the same step*. A step here refers to an individual command in your `codeship-steps.yml` file. ([Learn more about your Steps file here.]({{ site.baseurl }}/docker/steps/))

It's important to note that with this setup, data will be available between containers but will __not__ persist when the current step finishes and the next step begins.

To mount a volume to share data between your containers, first you need to open up your `codeship-service.yml` and specify a directory using the `volumes` directive on one of your services:

```yaml
data:
  image: busybox
  volumes:
    - /artifacts
```

Then, for your remaining services that require access to the volume, you will use the `volumes_from` directive in your other service definitions and specify which service you are reading the volume from (i.e. the one specified with your `volumes` directive.)

```yaml
myapp:
  image: busybox
  volumes_from:
    - data
```

[We have a downloadable example of this set up here.](https://github.com/codeship/codeship-tool-examples/tree/master/07.volumes)

### Passing Data Between Steps
The second setup solves the problem of persisting data *between* steps in your `codeship-services.yml` file. Since every step runs on a separate set of containers, date produced in one step is not normally available to a later step - but by mounting a volume on the host infrastructure you can persist data throughout your entire build.

 To mount a volume on the host, open your `codeship-services.yml` file and map a host directory to your container directory:

```yaml
data:
  image: busybox
  volumes:
    - /tmp/artifacts:/artifacts
```

On all other services that need to access this data, you can use either the `volumes_from` directive as explained in the previous example or simply provide the exact same `volumes` directive (with the host:container mapping) on all services that require access to your volume.

[We have a downloadable example of this set up here](https://github.com/codeship/codeship-tool-examples/tree/master/08.deployment-container)

## Common Use Cases
There are several common problems that volumes solve, including:

* Using a file in a shared volume as a "health check" to look for service availability or completion

* Passing credentials between steps or services

* Creating compiled assets and artifacts via one service to be deployed or pushed to an image registry from another service

* Avoiding re-work between steps (such as not re-seeding your database multiple times.)

As always, feel free to contact [support@codeship.com](mailto:support@codeship.com) if you have any questions.
