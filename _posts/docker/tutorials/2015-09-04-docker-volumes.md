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

## Using Docker volumes

Volumes can be used to connect containers in your build environment, and to share build artifacts between containers and steps in your pipeline.

Please see the [example in the codeship-tool examples repository](https://github.com/codeship/codeship-tool-examples/tree/master/07.volumes) of how to use volumes.

To connect containers using volumes, first define a volume on one container in your codeship-service.yml:

```yaml
data:
  image: busybox
  volumes:
    - /artifacts
```

You can then use the `volumes_from` declaration to mount this volume on another container.

```yaml
myapp:
  image: busybox
  volumes_from:
    - data
```

## Persisting volumes between steps

By default, all steps have an independent set of containers. As such, referencing a volume common to multiple steps will not reference the same base folder. This means not only containers, but also volumes, are isolated between steps.

To get around this, and share volumes between steps, simply define a static volume mount point:

```yaml
data:
  image: busybox
  volumes:
    - /tmp/artifacts:/artifacts
```

With this static volume mounting, every container mounting a volume, regardless of the step, will share the same base folder on the host. This allows build artifacts to be shared between steps of your build. For an example of this, check out the [deployment example](https://github.com/codeship/codeship-tool-examples/tree/master/08.deployment-container) showing how to build and share build artifacts between steps.

As always, feel free to contact [support@codeship.com](mailto:support@codeship.com) if you have any questions.
