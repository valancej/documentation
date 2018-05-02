---
title: Integrating Codeship With Depfu for Automated Dependency Updates
shortTitle: Using Depfu For Automated Dependency Updates
tags:
  - security
  - dependency management
  - dependency updates
  - integrations
  - dependencies
menus:
  general/integrations:
    title: Using Depfu
    weight: 22
categories:
  - Integrations
---

* include a table of contents
{:toc}

## About Depfu

[Depfu](https://depfu.com) automates updating your dependencies so you spend less time keeping your app up-to-date and secure.

Depfu continuously updates your dependencies one gem at a time and creates a pull request with all the info you need. You stay in control if and when to merge.

Starting with Depfu and Codeship is fast and easy. [The Depfu documentation](https://depfu.com/docs) does a great job of providing more information about how to set up Depfu itself, in addition to the instructions below.

{% csnote info %}
At the moment Depfu only works with Ruby projects hosted on GitHub. Support for more languages and other SCMs is planned.
{% endcsnote %}

## Codeship Pro

### GitHub Status API

Depfu uses the results of your build to show you the risk of a dependency update. For that Depfu doesn't run your tests, but gets the results directly from [GitHub Statuses](https://help.github.com/articles/about-statuses/).

If you use Codeship with a GitHub repo this works out of the box and is enabled by default. But it's configurable in the "General" settings for your Codeship project, so make sure to have that enabled.

You don't need to change anything in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}) to make Depfu work with Codeship.

### Branches and Pull Requests

Codeship Pro automatically builds all branches and pull requests that get pushed to GitHub, which is what Depfu needs to automate your dependency updates.

**Note** that if you have limited your "running the tests" step to only certain branches using the [tag/exclude attribute]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}/#limiting-steps-to-specific-branches-or-tags), make sure the Depfu branches are whitelisted. All Depfu branches start with `depfu/`.


## Codeship Basic

### GitHub Status API

Depfu uses the results of your build to show you the risk of a dependency update. For that Depfu doesn't run your tests, but gets the results directly from [GitHub Statuses](https://help.github.com/articles/about-statuses/).

If you use Codeship with a GitHub repo this works out of the box and is enabled by default. But it's configurable in the "General" settings for your Codeship project, so make sure to have that enabled.

You don't need to change anything in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) to make Depfu work with Codeship.

### Branches and Pull Requests

Codeship Basic automatically builds all branches and pull requests that get pushed to GitHub, which is what Depfu needs to automate your dependency updates.
