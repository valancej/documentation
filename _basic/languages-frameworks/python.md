---
title: Using Python In CI/CD with Codeship Basic
shortTitle: Python
menus:
  basic/languages:
    title: Python
    weight: 4
tags:
  - python
  - languages
  - flask
  - django

redirect_from:
  - /languages/python/
---

* include a table of contents
{:toc}

## Versions And Setup

We use [pyenv](https://github.com/pyenv/pyenv ) to manage Python environments for you.

By default, we run Python version `2.7.13`, but versions `3.4`, `3.5` and `3.6` are all preinstalled as well.

### Specifying Version

You have several options to specify which Python version you would like to use.

In your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) you can use **pyenv** commands. For instance:

```
pyenv local $version
```

You can also use the environment variable `PYENV_VERSION` to choose from one of the installed Python versions.

Alternatively, you can specify a version to use by committing a file named `.python-version` into your code repository with a version specification.

## Dependencies

You can use **pip** to install any dependencies in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

For example:

```shell
pip install -r requirements.txt
```

### Dependency Cache

Codeship automatically caches all dependencies installed through `pip`. You can [read this article to learn more]({{ site.baseurl }}{% link _basic/builds-and-configuration/dependency-cache.md %}) about the dependency cache and how to clear it.

## Frameworks And Testing

All Python frameworks, including Django, Flask and Pyramid, should work without issue as long as they do not require root-access for customized system configuration.

All test frameworks and tools, including pytest and unittest, should also work without issue.

## Parallel Testing

If you are running [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), you will want separate your tests into groups and call a group specifically in each pipeline. For instance:

**Pipeline 1**
```shell
py.test tests_1.py
```

**Pipeline 2**
```shell
py.test tests_2.py
```

### Parallelization Modules

In addition to parallelizing your tests explicitly [via parallel pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), you may find that there are packages available for parallelizing different types of testing, such as [nose-parallel](https://pypi.python.org/pypi/nose-parallel), to speed your tests up.

While we do not officially support or integrate with these modules, many Codeship users find success speeding their tests up by using them. Note that it is possible for these modules to cause resource and build failure issues, as well.

## Notes And Known Issues

Due to Python version issues, you may find it helpful to tests your commands with different versions via an [SSH debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}) if tests are running differently on Codeship compared to your local machine.

### Executable Not Available

As we use **pyenv**, if an executable is not available after installation you may need to run the command `pyenv rehash` after installing the package. [You can read pyenv's documentation](https://github.com/pyenv/pyenv) for more information.
