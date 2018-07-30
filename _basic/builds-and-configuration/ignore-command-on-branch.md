---
title: Ignore command on specific branch or run only on a branch
shortTitle: Ignoring Commands Per Branch
menus:
  basic/builds:
    title: Ignoring Commands
    weight: 8
tags:
  - commands
  - testing
categories:
  - Builds and Configuration
  - Testing
  - Configuration
redirect_from:
  - /faq/ignore-command-on-branch/
  - /basic/getting-started/ignore-command-on-branch/
---

* include a table of contents
{:toc}

## What is including or excluding a specific branch?

For a variety of reasons, you may want to either _only run_ commands on certain branches (i.e. only run custom alert commands on the `master` branch) or _exclude_ commands from running on certain branches (i.e. never run acceptance tests if on a branch that starts with `feature/*`).

Below you will find scripts that you can use on your project's [setup and test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) to accomplish both scenarios.

{% csnote info %}
These commands must be entered as single lines in your setup or test commands to be executed properly. Multiple line commands will get treated as separate commands instead of a single command. If you want to write a longer command as multiple lines, you should write it in a script file and then call that script instead.
{% endcsnote %}

## Using Include / Exclude Commands Per Branch

### Skip A Command On Specific Branches

If you don't want to run a command on a specific branch use the following syntax. In this example we run your command on every branch except `gh_pages`.

```shell
if [ "$CI_BRANCH" != "gh-pages" ]; then YOUR_COMMAND; fi
```

### Only Run A Command On Specific Branches

If you want to run a specific command only on one branch use the following syntax. In this example we run your command only on the master branch.

```shell
if [ "$CI_BRANCH" == "master" ]; then YOUR_COMMAND; fi
```
