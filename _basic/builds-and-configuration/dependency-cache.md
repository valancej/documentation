---
title: Speed Up Your Builds With Caching on Codeship Basic
menus:
  basic/builds:
    title: Caching
    weight: 4
tags:
  - cache
  - dependencies
  - speed
  - caching
redirect_from:
  - /basic/getting-started/dependency-cache/
---

* include a table of contents
{:toc}

<div class="info-block">
Note that this article addresses caching on **Codeship Basic**. If you are looking for information on caching with **Codeship Pro**, [click here]({{ site.baseurl }}{% link _pro/builds-and-configuration/caching.md %})
</div>

## What Is The Dependency Cache?

On all Codeship Basic projects, we automatically cache the dependency directories for several popular tools and frameworks to speed up future builds.

This means that all packages saved in these directories at the end of a build will be automatically loaded on the build machine for future builds.

## Using The Dependency Cache

Any packages, up to 500mb, in the following directories at the end of your build will be automatically cached:

- `$HOME/.ivy2`
- `$HOME/.m2/repository`
- `$HOME/cache/bundler`
- `$HOME/cache/yarn`
- `$HOME/cache`
- `$HOME/cache/pip`
- `$REPO_ROOT/node_modules`

Also note that we automatically configure `bundler` to write into `~/cache/bundler` as well as `yarn` to write into `$HOME/cache/yarn` and `pip` to write into `$HOME/cache/pip`.

### Clearing The Cache

You can manually clear the cache either by removing the populated cache directory in your setup commands at the start of your build (for instance, by adding a startup command `rm -rf node_modules`), by using our custom `cs clear-cache` command in your startup commands or by clicking on **Reset Dependency Cache** on the right sidebar when viewing any build.

**Note** that when clearing your dependency cache, you should wait 30-60 seconds to let the system run before triggering your next build.

![Reset Dependency Cache]({{ site.baseurl }}/images/basic-guide/reset-dependency-cache.png)
