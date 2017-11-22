---
title: SCM Support on Codeship
shortTitle: SCM Support
menus:
  general/about:
    title: SCM Support
    weight: 2
tags:
  - scm
  - vcs
  - github
  - bitbucket
  - gitlab
  - git
  - mercurial
  - on premise
  - enterprise
categories:
  - About Codeship  
---

* include a table of contents
{:toc}

Codeship supports [Git](https://git-scm.com) repositories hosted directly on [GitHub](https://github.com), [Bitbucket](https://bitbucket.org) and [GitLab](https://about.gitlab.com). There is [ongoing beta support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for on-premise versions of these SCM systems.

Integration between a repository and any forked repositories is not currently supported for any SCM. You can setup forked repositories as separate projects on Codeship, but any builds for the forked repository will not link back to the parent repository.

Get started by [creating a project]({{ site.baseurl }}{% link _general/projects/getting-started.md %}) on Codeship. If you are having trouble getting your SCM connected to Codeship, [check that the correct permissions are set]({{ site.baseurl }}{% link _general/about/permissions.md %}).

## GitHub

* Codeship can clone your GitHub repositories and report build statuses back via the [GitHub API](https://developer.github.com/v3/repos/statuses).

* Required [GitHub permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#github).

* There is [beta support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [GitHub Enterprise](https://enterprise.github.com/home).

## Bitbucket

* Codeship can clone your Bitbucket repositories and report build statuses back via the [Bitbucket API](https://confluence.atlassian.com/bitbucket/buildstatus-resource-779295267.html).

* Required [Bitbucket permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#bitbucket).

* In addition to Git repositories, [Mercurial](https://www.mercurial-scm.org) repositories on Bitbucket are also supported.

* There is [beta support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [Bitbucket Server](https://www.atlassian.com/software/bitbucket/server).

## GitLab

* Codeship can clone your GitLab repositories and report build statuses back via the [GitLab API](https://docs.gitlab.com/ce/api/commits.html#commit-status).

* Required [GitLab permissions]({{ site.baseurl }}{% link _general/about/permissions.md %}#gitlab).

* There is [beta support]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) for [GitLab Community Edition](https://gitlab.com/gitlab-org/gitlab-ce) and [GitLab Enterprise Edition](https://about.gitlab.com/gitlab-ee).

## Self-hosted Git Servers

Codeship has an ongoing beta allowing for support of GitHub Enterprise, GitLab Community Edition, GitLab Enterprise Edition and Bitbucket Server products.

This is a beta feature and you will need to [get in touch](mailto:solutions@codeship.com) to request access for free.

You can read the [self-hosted Git documentation]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) to learn more.

## SCM Feature Requests

We are continually evaluating our SCM integration support. If there is something you would like to see, please [get in touch](mailto:support@codeship.com) and let us know more details about your SCM needs.
