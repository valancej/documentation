---
title: Support For Git LFS Codeship
shortTitle: Git LFS
menus:
  general/about:
    title: GIT LFS
    weight: 7
tags:
  - git
  - lfs
categories:
  - About Codeship  
  - Configuration
---

* include a table of contents
{:toc}

Git LFS is not natively supported on Codeship, although we do provide [a script](https://github.com/codeship/scripts/blob/master/packages/git-lfs.sh) that may conditionally allow Git LFS to be usable in your builds.

## LFS On Codeship Pro

To use Git LFS on [Codeship Pro](https://codeship.com/features/pro) you will need to use [these lines of this script](https://github.com/codeship/scripts/blob/master/packages/git-lfs.sh#L31-L33).

You will need to run this script inside a container with both Git and Git LFS installed via the Dockerfile.

This container will also need to mount your entire cloned repository as volume in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}), such as:

```yaml
app:
  image: alpine:3.6
  volumes:
    - .:/data/
```
Within the container, in this `app` using an Alpine base image, you can then run `git lfs fetch` and `git lfs checkout` to get the files stored via LFS.

## LFS On Codeship Basic

To use Git LFS on [Codeship Basic](https://codeship.com/features/basic), you will need to install and setup [this script](https://github.com/codeship/scripts/blob/master/packages/git-lfs.sh) in your project's [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %})
