---
title: Speed Up Your Builds With Caching on Codeship Basic
shortTitle: Dependency Caching
menus:
  basic/builds:
    title: Caching
    weight: 4
tags:
  - cache
  - dependencies
  - speed
  - caching
categories:
  - Builds and Configuration  
  - Caching
redirect_from:
  - /basic/getting-started/dependency-cache/
---

* include a table of contents
{:toc}

{% csnote info %}
This article addresses caching on **Codeship Basic**. There is a separate guide for [caching on Codeship Pro]({{ site.baseurl }}{% link _pro/builds-and-configuration/caching.md %}).
{% endcsnote %}

## What Is The Dependency Cache?

On all Codeship Basic projects, we automatically cache the dependency directories for several popular tools to speed up future builds.

This means that all packages saved in these directories at the end of a build will be automatically loaded on the build machine for future builds.

## Using The Dependency Cache

Any packages, up to 500mb, in the following directories at the end of your build will be automatically cached:

- `$HOME/.ivy2`
- `$HOME/.m2/repository`
- `$HOME/cache`
- `$HOME/cache/bundler`
- `$HOME/cache/pip`
- `$HOME/cache/yarn`
- `$HOME/clone/node_modules`

We automatically configure `bundler` to write to `$HOME/cache/bundler`, `pip` to write to `$HOME/cache/pip` and `yarn` to write to `$HOME/cache/yarn`.

## Clearing The Cache

You can manually clear the dependency cache in several different ways:

- The simplest option is clicking the **Reset Cache** option from the dropdown when viewing any build. Be sure to allow 30-60 seconds after clearing before you trigger another build.

![Reset Dependency Cache]({{ site.baseurl }}/images/basic-guide/reset-dependency-cache.png)

- Use our custom `cs clear-cache` command at the start of your setup commands to clear everything under `$HOME/cache`.
- You can also manually clear out any specific cached directories by adding a setup command like `rm -rf node_modules`.

## Manual Caching

If you want to cache items in your build that are not already handled in the automatic configurations above you can also manually cache items. If the tool you are using provides a way to set a cache location, perhaps with an [environment variable]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}), you can point it to the `$HOME/cache` directory.

Otherwise you can manually copy items to `$HOME/cache` at the end of the build and then at the start of the build you can either copy them back out of the cache or create a symlink to the cached location.
