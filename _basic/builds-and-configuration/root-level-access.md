---
title: Running Commands As Sudo or Root
shortTitle: Using Sudo Or Root
menus:
  basic/builds:
    title: Running Commands As Root
    weight: 7
tags:
  - sudo
  - root
  - admin
  - apt-get
  - install
  - packages
  - ubuntu
categories:
  - Builds and Configuration
  - Configuration
  - Security
redirect_from:
  - /faq/root-level-access/
  - /basic/getting-started/root-level-access/
---

* include a table of contents
{:toc}

## Sudo and Root On CodeShip Basic

Although CodeShip Basic already has a long list of [packages installed]({{ site.baseurl }}{% link _basic/builds-and-configuration/packages.md %}), you can install most packages yourself if you find that something is missing. CodeShip Basic supports running commands as `sudo` giving you root-level access; with a few caveats.

### What Can You Do?

With the sudo access, you can run `apt-get update` and `apt-get install <package>` to install packages, even if they would normally require root-level access.

You can also start new services (custom or standard), assuming they don't try to do any of the things mentioned below.

**Note**: When you are looking for packages to install, look for those that work on `Ubuntu 14.04 (Trusty)` as that is the underlying Linux we use for the build machines. A newer version of Ubuntu (and other flavors) might be available later in the year.

### What Can't You Do?

Although you get sudo/root-level access, there are still things you can't do as CodeShip Basic is still a shared platform:

* Don't try and change system level resources
  * Resource limits (prlimit/ulimit/etc.)
  * Networking resources or settings (incl. adding IP addresses)
  * Loading kernel modules
  * Anything that relies on apparmor/selinux access
* Don't attempt to run any type of virtualization (virtual machine, docker, LXC, or other container-based tech).
* Don't expect any UI/Desktop-related stuff to work either. Headless browser testing is fine, but don't install an x-server and run gnome.

### What To Do If Things Fail?

With so many pre-installed packages, and the amount of packages that could potentially be installed, it's not unthinkable that what you're trying to do might not work.

Main thing to check is to make sure that whatever you're trying to install or start doesn't try to change resources (or anything else in the list above).

It is also possible (esp. for language versions) that you can install it differently, without having to manually install the package. An example could be installing a different version of Ruby using [rvm]({{ site.baseurl }}{% link _basic/languages-frameworks/ruby.md %}).
If it's not a language, double check the [list of installed packages]({{ site.baseurl }}{% link _basic/builds-and-configuration/packages.md %})

And if it's still failing, contact [support@codeship.com](mailto:support@codeship.com) so we can help you figure out what's going on.
