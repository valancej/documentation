---
title: Limit Builds to Specific Branches
layout: page
tags:
  - faq
  - builds
category: Projects
redirect_from:
  - /faq/limit_builds/
---
We don’t have a feature to limit which branches can be built.

We build your project on every push (that is, we run your setup and test commands) to let you know as soon as possible if something is broken. We will only ever run a deployment for the specific branch it is configured on and only after all setup and test commands executed successfully. In our opinion every push to your repository should be tested.

If you wish to skip a build, please refer to the article about skipping builds for [Codeship Basic]({{ site.baseurl }}{% link _basic/getting-started/skipping-builds.md %}) and [Codeship Pro]({{ site.baseurl }}{% link _pro/getting-started/skipping-builds.md %}) .
