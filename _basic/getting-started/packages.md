---
title: Packages on Codeship Basic
weight: 97
tags:
- AMI
- continuous integration
- packages
category: Getting Started
---

**current build: last edited on {{ site.data.basic.latest_update }}**

* include a table of contents
{:toc}

In a best effort to list the packages that are installed on our AMI (Amazon Machine Image) within our hosted Codeship environment, we offer the following list of installed packages. It might be **partly incomplete**, but we hope it offers good value and transparency.

If you want to check a certain package or default version for yourself, you can use the SSH Debug session within your project and connect directly to our build machine.

![Open SSH Debug Session]({{ site.baseurl }}/images/basic/open_ssh.png)

Click on the link to open an SSH debug session. You will be provided with the username, server, and port which you can use to access the build machine. You will need an SSH key in your .ssh folder (default). For more information, please read our documentation on [SSH access]({{ site.baseurl }}{% link _basic/getting-started/ssh-access.md %}).



## NodeJS versions available via nvm
{% include basic/ami/{{ site.data.basic.ami_id }}/node.md %}


## PHP Versions available via phpenv
{% include basic/ami/{{ site.data.basic.ami_id }}/php.md %}

## Ruby versions available via rvm
{% include basic/ami/{{ site.data.basic.ami_id }}/ruby.md %}

## Full list of installed packages
{% include basic/ami/{{ site.data.basic.ami_id }}/packages.md %}
