---
title: Python
weight: 70
tags:
  - python
  - languages
category: Languages &amp; Frameworks
redirect_from:
  - /languages/python/
---

* include a table of contents
{:toc}

We use **virtualenv** to manage Python environments for you. We currently support Python `2.7.6`. Version `3.4.3` of Python is installed as well and available via the `python3` binary.

## Dependencies
You can use **pip** to install any dependencies, for example:

```shell
pip install -r requirements.txt
```

## Python 3
The virtual environment from `${HOME}/.virtualenv` is activated and configured for use with Python 2 by default. If you want to switch to version 3, simply add the following commands to your _Setup Commands_.

```shell
virtualenv -p $(which python3) "${HOME}/cache/python3_env"
source "${HOME}/cache/python3_env/bin/activate"
```

## Additional Versions
If you need a specific Python version installed, use [this script](https://github.com/codeship/scripts/blob/master/languages/python.sh) in your _Setup Commands_.

First set the desired version as an [environment variable]({{ site.baseurl }}{% link _basic/getting-started/set-environment-variables.md %}) in your project.

```shell
PYTHON_VERSION=3.6.0
```

Next add [this command](https://github.com/codeship/scripts/blob/master/languages/python.sh#L10) to your _Setup Commands_ and the script will automatically be called at build time.

## Dependency Cache

Codeship automatically caches the `$HOME/.virtualenv/lib/python2.7/site-packages` directory between builds to optimize build performance. You can [read this article to learn more]({{ site.baseurl }}{% link _basic/getting-started/dependency-cache.md %}) about the dependency cache and how to clear it.
