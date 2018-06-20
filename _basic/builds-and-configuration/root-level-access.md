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

## Sudo and Root On Codeship Basic

Codeship Basic currently does not allow root level access (i.e. commands run via `sudo`) for security reasons. We now have a beta feature that will allow `sudo` commands. If you need to install a dependency that is not available via a language specific package manager (e.g. `gem`, `pip`, `npm` or a similar tool), please contact [support@codeship.com](mailto:support@codeship.com) and we can add you to the beta feature.
