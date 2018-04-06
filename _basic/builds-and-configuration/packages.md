---
title: Codeship Basic Package List
shortTitle: Codeship Basic Package List
description: Technical documentation listing all pre-installed packages and tools of the Codeship Basic build environment
menus:
  basic/builds:
    title: Installed Packages
    weight: 1
tags:
- AMI
- packages
categories:
  - Builds and Configuration
redirect_from:
  - /basic/getting-started/packages/
---

<div class="info-block">
This page was last updated on {{ site.data.basic.latest_update }}.
</div>

* include a table of contents
{:toc}

## Codeship Pre-Installed Packages And Tools

In a best effort to list everything installed on Codeship Basic, we offer the following list of installed packages. While the list may not be fully complete at any given moment, we try our best to keep it comprehensive and up to date.

## Check For Packages Versions Via SSH Session

If you want to check for a certain package or see what the default version is for yourself, you can use the [SSH Debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}) within your project and connect directly to our build machine.

![Reset Dependency Cache]({{ site.baseurl }}/images/basic-guide/ssh-debug.png)

Click on the link to open an SSH debug session. You will be provided with the username, server, and port which you can use to access the build machine. You will need an SSH key in your .ssh folder (default). For more information, please read our documentation on [SSH access]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}).

## Full list of installed packages
{% include basic/ami/{{ site.data.basic.ami_id }}/packages.md %}

## Java versions available via jdk_switcher
{% include basic/ami/{{ site.data.basic.ami_id }}/java.md %}

## NodeJS versions available via nvm
{% include basic/ami/{{ site.data.basic.ami_id }}/node.md %}

## PHP Versions available via phpenv
{% include basic/ami/{{ site.data.basic.ami_id }}/php.md %}

## Python Versions available via pyenv
{% include basic/ami/{{ site.data.basic.ami_id }}/python.md %}

## Ruby versions available via rvm
{% include basic/ami/{{ site.data.basic.ami_id }}/ruby.md %}
