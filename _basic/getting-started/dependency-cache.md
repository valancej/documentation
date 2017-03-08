---
title: Dependency Cache on Codeship Basic
weight: 85
tags:
  - cache
  - dependencies
category: Getting Started
---

<div class="info-block">
Note that this article addresses caching on **Codeship Basic**. If you are looking for information on caching with **Codeship Pro**, [click here]({{ site.baseurl }}{% link _pro/getting-started/caching.md %})
</div>

## Automatic Dependency Caching

On all Codeship Basic projects, we automatically cache the dependency directories for several popular tools and frameworks to speed up future builds.

This means that all packages saved in these directories at the end of a build will be automatically loaded on the build machine for future builds.

Packages in the following directories will be automatically cached:

- `~/node_modules`
- `~/clone/node_modules-cache`
- `~/.virtualenv/bin/`
- `~/.virtualenv/lib/python2.7/site-packages`
- `~/.m2/repository`
- `~/clone/tmp/parallel_runtime_cucumber.log`
- `~/.ivy2`
- `~/cache/bundler`

Also note that we automatically configure `bundler` to write into `~/cache/bundler`.

## Clearing The Cache

You can manually clear the cache either by removing the populated cache directory in your setup commands at the start of your build (for instance, by adding a startup command `rm -rf node_modules`), by using our custom `cs clear-cache` command in your startup commands or by clicking on **Reset Dependency Cache** on the right sidebar when viewing any build.

**Note** that when clearing your dependency cache, you should wait 30-60 seconds to let the system run before triggering your next build.

![Clearing the dependency cache]({{ site.baseurl }}/images/continuous-integration/clear_cache.png)

## Support

As always, feel free to contact [support@codeship.com](mailto:support@codeship.com) if you have any questions.
